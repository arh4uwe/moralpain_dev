/*
 * MoralDistress API
 * MoralDistress API.
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


package org.openapitools.client.model;

import java.util.Objects;
import java.util.Arrays;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonValue;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.util.ArrayList;
import java.util.List;
import org.openapitools.client.model.SurveyOption;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.annotation.JsonTypeName;

/**
 * SurveySection
 */
@JsonPropertyOrder({
  SurveySection.JSON_PROPERTY_SECTION_ID,
  SurveySection.JSON_PROPERTY_TITLE,
  SurveySection.JSON_PROPERTY_SUBTITLE,
  SurveySection.JSON_PROPERTY_OPTIONS
})
@JsonTypeName("surveySection")
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.JavaClientCodegen", date = "2022-05-20T14:16:52.838332-04:00[America/New_York]")
public class SurveySection {
  public static final String JSON_PROPERTY_SECTION_ID = "sectionId";
  private String sectionId;

  public static final String JSON_PROPERTY_TITLE = "title";
  private String title;

  public static final String JSON_PROPERTY_SUBTITLE = "subtitle";
  private String subtitle;

  public static final String JSON_PROPERTY_OPTIONS = "options";
  private List<SurveyOption> options = null;

  public SurveySection() { 
  }

  public SurveySection sectionId(String sectionId) {
    
    this.sectionId = sectionId;
    return this;
  }

   /**
   * Get sectionId
   * @return sectionId
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_SECTION_ID)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public String getSectionId() {
    return sectionId;
  }


  @JsonProperty(JSON_PROPERTY_SECTION_ID)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setSectionId(String sectionId) {
    this.sectionId = sectionId;
  }


  public SurveySection title(String title) {
    
    this.title = title;
    return this;
  }

   /**
   * Get title
   * @return title
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_TITLE)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public String getTitle() {
    return title;
  }


  @JsonProperty(JSON_PROPERTY_TITLE)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setTitle(String title) {
    this.title = title;
  }


  public SurveySection subtitle(String subtitle) {
    
    this.subtitle = subtitle;
    return this;
  }

   /**
   * Get subtitle
   * @return subtitle
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_SUBTITLE)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public String getSubtitle() {
    return subtitle;
  }


  @JsonProperty(JSON_PROPERTY_SUBTITLE)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setSubtitle(String subtitle) {
    this.subtitle = subtitle;
  }


  public SurveySection options(List<SurveyOption> options) {
    
    this.options = options;
    return this;
  }

  public SurveySection addOptionsItem(SurveyOption optionsItem) {
    if (this.options == null) {
      this.options = new ArrayList<>();
    }
    this.options.add(optionsItem);
    return this;
  }

   /**
   * Get options
   * @return options
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_OPTIONS)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public List<SurveyOption> getOptions() {
    return options;
  }


  @JsonProperty(JSON_PROPERTY_OPTIONS)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setOptions(List<SurveyOption> options) {
    this.options = options;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    SurveySection surveySection = (SurveySection) o;
    return Objects.equals(this.sectionId, surveySection.sectionId) &&
        Objects.equals(this.title, surveySection.title) &&
        Objects.equals(this.subtitle, surveySection.subtitle) &&
        Objects.equals(this.options, surveySection.options);
  }

  @Override
  public int hashCode() {
    return Objects.hash(sectionId, title, subtitle, options);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class SurveySection {\n");
    sb.append("    sectionId: ").append(toIndentedString(sectionId)).append("\n");
    sb.append("    title: ").append(toIndentedString(title)).append("\n");
    sb.append("    subtitle: ").append(toIndentedString(subtitle)).append("\n");
    sb.append("    options: ").append(toIndentedString(options)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }

}
