package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;

import edu.uva.cs.moralpain.utils.S3Helper;
import edu.uva.cs.moralpain.utils.VariableManager;

import org.openapitools.client.model.Submission;

import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.util.Collections;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

/**
 * Get the timestamp of the submission with the given UUID
 */
public class SubmissionFieldFetcher implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent input, Context context) {
        System.out.println("path: " + input.getRawPath());

        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if (!isValidEvent(input)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if (!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }

        String bucket = variableManager.get("bucket");
        String prefix = variableManager.getOrDefault("prefix", "");

        Map<String, String> qs = input.getQueryStringParameters();
        if (qs == null) {
            qs = Collections.EMPTY_MAP;
        }
        SubmissionFetcherPredicateBuilder sfpb = new SubmissionFetcherPredicateBuilder(qs);
        String uuid = qs.get("uuid");

        // If no UUID is given, return a 400 response.
        if (uuid == null) {
            response.setBody("Required UUID parameter is missing");
            response.setStatusCode(400);
        } else {
            // Get the list of submissions with the given UUID
            S3Client client = createS3Client(variableManager);
            ListObjectsV2Request.Builder builder = ListObjectsV2Request.builder()
                    .bucket(bucket)
                    .prefix(prefix);
            ListObjectsV2Request listObjectsV2Request = builder.build();

            List<Submission> submissions = client.listObjectsV2(listObjectsV2Request).contents()
                    .stream()
                    .map(S3Object::key)
                    .map(key -> S3Helper.getObjectAsSubmission(client, bucket, key))
                    .filter(sfpb.hasUuid())
                    .collect(Collectors.toList());

            // If there is no submission with the given UUID, return a 400 response.
            if (submissions.isEmpty()) {
                response.setBody("No submission found with UUID " + uuid);
                response.setStatusCode(400);
            }
            // If there is a submission with the given UUID, return a 200 response.
            else {
                response.setBody("" + submissions.get(0).getTimestamp());
                response.setStatusCode(200);
            }
        }

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "text/plain");
        headers.put("X-Custom-Header", "text/plain");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return event != null;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }

}