<!doctype html>
<html>
  <head>
    <meta name="layout" content="bootstrap"/>
    <title>KB+ Data import explorer</title>
  </head>

  <body>
    <div class="row-fluid">
      <p>
        You are seeing this page because you have editor level access to more than one institution. Please
        select from the list below.
      </p>
      <ul>
        <g:each in="${orgs}" var="o">
          <li>${o.name} | 
            <g:link controller="myInstitutions" action="manageLicenses" params="${[shortcode:o.shortcode]}" class="btn btn-primary btn-small"><i class="icon-edit icon-white"></i>Manage Licenses</g:link>
          </li>
        </g:each>
      </ul>
    </div>
  </body>
</html>
