<div class="well documents">
  <h7>Documents</h7>
  <ul>
    <g:each in="${doclist}" var="docctx">
      <g:if test="${docctx.owner?.contentType==1}">
        <li class="externalLinkIcon">
          <a href="http://knowplus.edina.ac.uk/oledocstore/document?uuid=${docctx.owner?.uuid}">
            Legacy Docstore Link
          </a><br/>
          <g:link controller="docstore" id="${docctx.owner.uuid}">
            ${docctx.owner.id} 
            <g:if test="${docctx.owner?.title}"> : <em>${docctx.owner.title}</em><br/></g:if>
            <g:else>
              <g:if test="${docctx.owner?.filename}">${docctx.owner.filename}</g:if>
              <g:else>Missing title and filename</g:else>
            </g:else>
          </g:link>
        </li>
      </g:if>
    </g:each>
  </ul>
  <input type="submit" class="btn btn-primary" value="Add new document" data-toggle="modal" href="#modalCreateDocument" />
</div>

<!-- Lightbox modal for creating a document taken from licenceDocuments.html -->
<div class="modal hide" id="modalCreateDocument">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Create New Document</h3>
  </div>
  <g:form id="upload_new_doc_form" url="[controller:'myInstitutions',action:'uploadDocument']" method="post" enctype="multipart/form-data">
    <input type="hidden" name="licid" value="${license.id}"/>
    <input type="hidden" name="shortcode" value="${shortcode}"/>
    <div class="modal-body">
      <dl>
        <dt>
          <label>Document Name:</label>
        </dt>
        <dd>
          <input type="text" name="upload_title">
        </dd>
      </dl>
      <dl>
        <dt>
          <label>File:</label>
        </dt>
        <dd>
          <input type="file" name="upload_file" />
        </dd>
      </dl>
    </div>
    <div class="modal-footer">
      <a href="#" class="btn" data-dismiss="modal">Close</a>
      <input type="submit" class="btn btn-primary" value="Save Changes">
    </div>
  </g:form>
</div>
<!-- End lightbox modal -->
