<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+ User Profile</title>
  </head>

  <body>

    <div class="container">
        <ul class="breadcrumb">
        <li> <g:link controller="home">KBPlus</g:link> <span class="divider">/</span> </li>
        <li class="active">Profile</li>
      </ul>
    </div>

  <g:if test="${flash.error}">
      <div class="container">
          <bootstrap:alert class="error-info">${flash.error}</bootstrap:alert>
      </div>
  </g:if>

    <g:if test="${flash.message}">
    <div class="container">
       <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
    </div>
    </g:if>


		<div class="container">
			<div class="span12">
				<h1>Preferences</h1>
			</div>
		</div>
		<div class="container">
      <div class="span12">
        <dl class="dl-horizontal">
	        <div class="control-group">
            <dt>Show Info Icon</dt>
            <dd>
              <g:xEditableRefData owner="${user}" field="showInfoIcon" config="YN" />
            </dd>
          </div>
        </dl>
      </div>
    </div>

    <div class="container">
      <div class="span12">
        <h1>User Profile</h1>
      </div>
    </div>

    <div class="container">
      <div class="span12">
        <g:form action="updateProfile" class="form-inline">
          <dl class="dl-horizontal">

          <div class="control-group">
            <dt>Display Name</dt>
            <dd><input type="text" name="userDispName" value="${user.display}"/></dd>
          </div>

          <div class="control-group">
            <dt>Email Address</dt>
            <dd><input type="text" name="email" value="${user.email}"/></dd>
          </div>

          <div class="control-group">
            <dt>Default Page Size</dt>
            <dd><input type="text" name="defaultPageSize" value="${user.defaultPageSize}"/></dd>
          </div>

          <div class="control-group">
            <dt>Default Dashboard</dt>
            <dd>
              <select name="defaultDash" value="${user.defaultDash?.id}">
                <g:each in="${user.authorizedOrgs}" var="o">
                  <option value="${o.id}" ${user.defaultDash?.id==o.id?'selected':''}>${o.name}</option>
                </g:each>
              </select>
            </dd>
          </div>

          <div class="control-group">
            <dt></dt>
            <dd><input type="submit" value="Update Profile" class="btn btn-primary"/></dd>
          </div>

          <p>Please note, membership requests may be slow to process if you do not set a meaningful display name and email address. Please ensure
               these are set correctly before requesting institutional memberships</p>
        </g:form>
      </div>
    </div>


    <div class="container">
      <div class="span12">
        <h1>Administrative memberships</h1>
      </div>
    </div>

    <div class="container"><div class="row-fluid">
      <div class="span6">
        <div class="well">
          <h2>Existing Memberships</h2>

          <table class="table table-striped table-bordered table-condensed">
            <thead>
              <tr>
                <th>Organisation</th>
                <th>Role</th>
                <th>Status</th>
                <th>Date Requested / Actioned</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <g:each in="${user.affiliations}" var="assoc">
                <tr>
                  <td><g:link controller="organisations" action="info" id="${assoc.org.id}">${assoc.org.name}</g:link></td>
                  <td><g:message code="cv.roles.${assoc.formalRole?.authority}"/></td>
                  <td><g:message code="cv.membership.status.${assoc.status}"/></td>
                  <td><g:formatDate format="dd MMMM yyyy" date="${assoc.dateRequested}"/> / <g:formatDate format="dd MMMM yyyy" date="${assoc.dateActioned}"/></td>
                  <td><!--<button class="btn">Remove</button>--></td>
                </tr>
              </g:each>
            </tbody>
          </table>
        </div>
      </div>

      <div class="span6">
        <div class="well">
          <h2>Request new membership</h2>
          <p>Select an organisation and a role below. Requests to join existing
             organisations will be referred to the administrative users of that organisation. If you feel you should be the administrator of an organisation
             please contact the KBPlus team for support.</p>
  
          <g:form id="affiliationRequestForm" controller="profile" action="processJoinRequest" form class="form-search">

            <g:select name="org"
                      from="${com.k_int.kbplus.Org.findAllBySector('Higher Education',[sort:'name'])}"
                      optionKey="id"
                      optionValue="name"
                      class="input-medium"/>

            <g:select name="formalRole"
                      from="${com.k_int.kbplus.auth.Role.findAllByRoleType('user')}"
                      optionKey="id"
                      optionValue="${ {role->g.message(code:'cv.roles.'+role.authority) } }"
                      class="input-medium"/>

            <button id="submitARForm" data-complete-text="Request Membership" type="submit" class="btn btn-primary btn-small">Request Membership</button>
          </g:form>
        </div>
      </div>
    </div></div>

  </body>
</html>
