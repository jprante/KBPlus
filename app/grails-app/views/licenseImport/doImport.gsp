<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap">
    <g:set var="entityName" value="${message(code: 'opl.license.label',
            default: 'ONIX-PL License')}" />
    <title><g:message code="default.import.label" args="[entityName]" /></title>
  </head>
  <body>
      <div class="container">

        <div class="page-header">
            <h1>Import ONIX-PL License
            <g:if test="${license}"> for license '${license.reference}'</g:if>
            <g:else> for unspecified license</g:else>
            </h1>
        </div>

          <g:if test="${flash.message}">
              <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
          </g:if>

          <g:if test="${flash.error}">
              <bootstrap:alert class="alert-info">${flash.error}</bootstrap:alert>
          </g:if>

          <g:hasErrors bean="${packageInstance}">
              <bootstrap:alert class="alert-error">
                  <ul>
                      <g:eachError bean="${packageInstance}" var="error">
                          <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                      </g:eachError>
                  </ul>
              </bootstrap:alert>
          </g:hasErrors>

      <%-- Show summary first, if the upload has been validated --%>
          <g:if test="${validationResult?.messages}">
              <g:each in="${validationResult.messages}" var="msg">
                  <div class="alert alert-info">${msg}</div>
              </g:each>
          </g:if>
          <g:else>
          <%--<div class="alert alert-info">No messages!</div>--%>
          </g:else>

          <g:if test="${validationResult?.errors}">
              <g:each in="${validationResult.errors}" var="msg">
                  <div class="alert alert-error">${msg}</div>
              </g:each>
          </g:if>

      <%-- Show a summary of the created OPL if one exists --%>
          <g:if test="${validationResult?.onixpl_license}">
              <div class="alert alert-success">
                  <h2>Upload successful</h2>

                  <%--Imported ${upload_filename} (${upload_mime_type})--%>
                  Imported ${upload_filename} (${upload_mime_type})
                  <g:if test="${validationResult.license}">
                      and associated with
                      <%--${validationResult.replace ? '' : 'new'}--%>
                      <g:link action="onixpl"
                              controller="licenseDetails"
                              class="btn btn-info"
                              id="${validationResult.license.id}">
                          License ${validationResult.license.id}
                      </g:link>
                      ${validationResult.license.reference}.
                  </g:if>
                  <g:else>
                      <br/>
                      Existing associations with KB+ licenses were maintained.
                  </g:else>

                  <g:if test="${validationResult.termStatuses!=null}">
                      <h2>Usage terms summary</h2>
                      <ul>
                          <g:each in="${validationResult.termStatuses}" var="ts">
                              <li>${ts.value} &times ${ts.key}</li>
                          </g:each>
                      </ul>
                  </g:if>

                  <br/>
                  <g:link action="index"
                          controller="onixplLicenseDetails"
                          class="btn btn-info"
                          id="${validationResult.onixpl_license.id}">
                      View ${validationResult.replace ? 'updated' : 'new'} ONIX-PL license</g:link>

              </div>
          </g:if>


      <%-- Show the form if no OPL has been created --%>
          <g:else>
              <g:form action="doImport" method="post" enctype="multipart/form-data">
                  <g:hiddenField name="license_id" value="${params.license_id!=""?params.license_id:license_id}" />
              <%-- Show overwrite option if there is an existing OPL --%>
                  <g:if test="${existing_opl}">
                      This ONIX-PL document appears to describe an existing ONIX-PL license:
                      <div class="well">
                          <g:link action="index"
                                  controller="onixplLicenseDetails"
                                  id="${existing_opl.id}">
                              ${existing_opl.title}
                          </g:link>
                      </div>
                      Would you like to replace the existing ONIX-PL license or create a new record?
                      <br/>
                      <br/>
                      <button name="replace_opl" id="replace_opl" value="replace"
                              type="submit" class="btn btn-danger">Replace</button>
                      <button name="replace_opl" id="replace_opl" value="create"
                              type="submit" class="btn btn-primary">Create New</button>

                      <g:hiddenField name="upload_title" value="${upload_title}" />
                      <g:hiddenField name="uploaded_file" value="${uploaded_file}" />

                      <g:hiddenField name="upload_filename" value="${upload_filename}" />
                      <g:hiddenField name="upload_mime_type" value="${upload_mime_type}" />
                      <g:hiddenField name="existing_opl_id" value="${existing_opl.id}" />

                  </g:if>
              <%-- Show  default options is there is no existing OPL and one has not been created --%>
                  <g:else>
                      <%--Upload File:--%>
                      <br/>
                      <input type="file" id="import_file" name="import_file" value="${import_file}"/>
                      <br/>
                      <br/>
                      <button type="submit" class="btn btn-primary">
                          Import license
                      </button>
                  </g:else>
              </g:form>
          </g:else>

      </div>
  </body>
</html>