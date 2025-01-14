const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                          "PoolId": "us-east-1:c028d79f-e179-4f13-89b2-e66cbd675fd8",
                          "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_pqNwySoyF",
                        "AppClientId": "7402ua1jc98ho8ach5ejfn53j1",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "OAuth": {
                            "WebDomain": "moralpain-user-pool-domain.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "7402ua1jc98ho8ach5ejfn53j1",
                            "SignInRedirectURI": "myapp://",
                            "SignOutRedirectURI": "myapp://",
                            "Scopes": [ 
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                                      },
              "authenticationFlowType": "USER_SRP_AUTH",
              "socialProviders": [],
              "usernameAttributes": [],
              "signupAttributes": [
                "EMAIL",
                "NAME"

              ],
              "passwordProtectionSettings": {
                "passwordPolicyMinLength": 8,
                "passwordPolicyCharacters": []
              },
              "mfaConfiguration": "OFF",
              "mfaTypes": [
                "SMS"
              ],
              "verificationMechanisms": [
                "EMAIL"
              ]
            }
          }
        }
      }
    }
}''';
