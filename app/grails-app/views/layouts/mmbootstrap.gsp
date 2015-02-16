<%@ page import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>

<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
    <meta name="description" content="">
    <meta name="viewport" content="initial-scale = 1.0">

    <r:require modules="kbplus"/>

    <g:layoutHead/>

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">


    <r:layoutResources/>
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
            <ul class="nav">
                    <g:link controller="home" action="index" class="brand" alt="KB+ ${grailsApplication.metadata.'app.version'} / build ${grailsApplication.metadata.'app.buildNumber'}">KB+</g:link>
                <sec:ifLoggedIn>
                <ul class="nav">
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle explorer-link" data-toggle="dropdown"> Data Explorer <b class="caret"></b> </a>
                    <ul class="dropdown-menu" style="max-width:none;">
                      <li<%= request.forwardURI == "${createLink(uri: '/home/search')}" ? ' class="active"' : '' %>><a href="${createLink(uri: '/home/search')}">Search</a></li>
                      <li <%='package'== controllerName ? ' class="active"' : '' %>><g:link controller="package">Package</g:link></li>
                      <li <%='org'== controllerName ? ' class="active"' : '' %>><g:link controller="org">Organisations</g:link></li>
                      <li <%='platform'== controllerName ? ' class="active"' : '' %>><g:link controller="platform">Platform</g:link></li>
                      <li <%='titleInstance'== controllerName ? ' class="active"' : '' %>><g:link controller="titleInstance">Title Instance</g:link></li>
                      <li <%='titleInstancePackagePlatform'== controllerName ? ' class="active"' : '' %>><g:link controller="titleInstancePackagePlatform">Title Instance Package Platform</g:link></li>
                      <li <%='subscription'== controllerName ? ' class="active"' : '' %>><g:link controller="subscription">Subscriptions</g:link></li>
                      <li <%='license'== controllerName ? ' class="active"' : '' %>><g:link controller="license">Licences</g:link></li>
                      <li <%='onixplLicenseDetails'== controllerName ? ' class="active"' : '' %>><g:link controller="onixplLicenseDetails" action="list">ONIX-PL Licences</g:link></li>
                    </ul>
                  </li>
                </sec:ifAnyGranted>
                </ul>
                <ul class="nav">
                <g:if test="${user}">
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Institutions <b class="caret"></b> </a>
                    <ul class="dropdown-menu" style="max-width:none;">


                       <li><g:link controller="packageDetails" action="index">All Packages</g:link></li>
                       <li><g:link controller="titleDetails" action="index">All Titles</g:link></li>
                       <li><g:link controller="packageDetails" action="compare">Compare Packages</g:link></li>
                       <li><g:link controller="onixplLicenseCompare"
                                   action="index">Compare ONIX-PL Licences</g:link></li>
                       <li class="divider"></li>
                       <g:set var="usaf" value="${user.authorizedOrgs}" />
                       <g:if test="${usaf && usaf.size() > 0}">
                         <g:each in="${usaf}" var="org">
                           <li class="dropdown-submenu">
                             <a href="#" class="dropdown-toggle" data-toggle="dropdown">${org.name} </a>
                             <ul class="dropdown-menu">
                               <li><g:link controller="myInstitutions"
                                           action="instdash"
                                           params="${[shortcode:org.shortcode]}">Dashboard</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="todo"
                                           params="${[shortcode:org.shortcode]}">ToDo List</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="currentLicenses"
                                           params="${[shortcode:org.shortcode]}">Licences</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="currentSubscriptions"
                                           params="${[shortcode:org.shortcode]}">Subscriptions</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="currentTitles"
                                           params="${[shortcode:org.shortcode]}">Titles</g:link></li>
                               <li><g:link controller="subscriptionDetails" 
                                           action="compare"
                                           params="${[shortcode:org.shortcode]}">Compare Subscriptions</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="renewalsSearch"
                                           params="${[shortcode:org.shortcode]}">Generate Renewals Worksheet</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="renewalsUpload"
                                           params="${[shortcode:org.shortcode]}">Import Renewals</g:link></li>
                               <li><g:link controller="organisations"
                                           action="show"
                                           params="${[id:org.id]}">Organisation Information</g:link></li>
                               <li><g:link controller="subscriptionImport"
                                           action="generateImportWorksheet"
                                           params="${[id:org.id]}">Generate Subscription Taken Worksheet</g:link></li>
                               <li><g:link controller="subscriptionImport"
                                           action="importSubscriptionWorksheet"
                                           params="${[id:org.id]}">Import Subscription Taken Worksheet</g:link></li>
                               <li><g:link controller="myInstitutions"
                                           action="changeLog"
                                           params="${[shortcode:org.shortcode]}">Change Log</g:link></li>

                             </ul>
                           </li>
                         </g:each>
                       </g:if>
                       <g:else>
                         <li>Please request institutional affiliations via your <g:link controller="profile" action="index">Profile Page</g:link></li>
                       </g:else>
                       <li class="divider"></li>
                       <li><a href="${message(code:'help.location')}">Help</a></li>
                       <li><a href="https://sp.kbplus.ac.uk/claimIdentity/notify?remote=${user.username}">Claim Username</a></li>
                    </ul>
                  </li>
                </g:if>
                </ul>
                <ul class="nav">
                <sec:ifAnyGranted roles="ROLE_ADMIN,KBPLUS_EDITOR">
                   <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Data Managers <b class="caret"></b> </a>
                     <ul class="dropdown-menu">
                       <li <%= ( ( 'dataManager'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="dataManager" action="index">Data Manager Dashboard</g:link></li>
                       <li class="divider"></li>
                       <li <%= ( ( 'announcement'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="announcement" action="index">Announcements</g:link></li>
                       <li <%= ( ( 'packageDetails'== controllerName ) && ( 'list'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="packageDetails" action="list">Search Packages</g:link></li>
                       <li class="divider"></li>
                         <li <%= ( ( 'upload'== controllerName ) && ( 'reviewPackage'==actionName ) ) ? ' class="active"' : '' %>>
                             <g:link controller="upload" action="reviewPackage">Upload new Package</g:link></li>
                         <li <%= ( ( 'licenseImport'== controllerName ) && ( 'doImport'==actionName ) ) ? ' class="active"' : '' %>>
                             <g:link controller="licenseImport" action="doImport">${message(code:'onix.import.licence')}</g:link></li>
                       <li class="divider"></li>
                       <li <%= ( ( 'titleDetails'== controllerName ) && ( 'findTitleMatches'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="titleDetails" action="findTitleMatches">New Title</g:link></li>
                       <li <%= ( ( 'licenseDetails'== controllerName ) && ( 'create'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="licenseDetails" action="create">${message(code:'licence.new')}</g:link></li>
                       <li class="divider"></li>

                        <li<%= ( ( 'subscriptionDetails'== controllerName ) && ( 'compare'==actionName ) ) ? ' class="active"' : '' %>><g:link controller="subscriptionDetails" 
                                           action="compare">Compare Subscriptions</g:link></li>

                       <li <%= ( ( 'subscriptionImport'== controllerName ) && ( 'generateImportWorksheet'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="subscriptionImport" action="generateImportWorksheet">Generate Subscription Taken Worksheet</g:link></li>
                       <li <%= ( ( 'subscriptionImport'== controllerName ) && ( 'importSubscriptionWorksheet'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="subscriptionImport" action="importSubscriptionWorksheet" params="${[dm:'true']}">Import Subscription Taken Worksheet</g:link></li>
                       <li <%= ( ( 'dataManager'== controllerName ) && ( 'changeLog'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="dataManager" action="changeLog">Data Manager Change Log</g:link></li>
                       <li class="divider"></li>
                       <li <%= ( ( 'globalDataSync'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="globalDataSync" action="index">Global Data Download [Packages]</g:link></li>
                       <li class="divider"></li>
                         <li <%= ( ( 'jasperReports'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                             <g:link controller="jasperReports" action="index">Reports</g:link></li>
                         <li <%= ( ( 'admin'== controllerName ) && ( 'managePropertyDefinitions'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="managePropertyDefinitions">Manage Property Definitions</g:link></li>

                     </ul>
                   </li>
                </sec:ifAnyGranted>
                </ul>
                <ul class="nav">
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                   <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Admin Actions <b class="caret"></b> </a>
                    <ul class="dropdown-menu">
                      <li <%= ( ( 'admin'== controllerName ) && ( 'manageAffiliationRequests'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="manageAffiliationRequests">Manage Affiliation Requests</g:link></li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'settings'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="settings">System Settings</g:link></li>
                      <li class="divider"></li>
                      <li <%= ( ( 'organisations'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="organisations" action="index">Manage Organisations</g:link>
                      </li>
                      <li <%= ( ( 'startFTIndex'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="startFTIndex" action="index">Start ES Index Update</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'showAffiliations'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="showAffiliations">Show Affiliations</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'allNotes'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="allNotes">All Notes</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'dataCleanse'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="dataCleanse">Run Data Cleaning (Nominal Platforms)</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'titleAugment'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="titleAugment">Run Data Cleaning (Title Augment)</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'fullReset'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="fullReset">Run Full ES Index Reset</g:link>
                      </li>
                      <li <%= ( ( 'userDetails'== controllerName ) && ( 'list'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="userDetails" action="list">User Details</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'forumSync'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="forumSync">Run Forum Sync</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'juspSync'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="juspSync">Run JUSP Sync</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'manageContentItems'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="manageContentItems">Manage Content Items</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'forceSendNotifications'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="forceSendNotifications">Send Pending Notifications</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'titleMerge'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="titleMerge">Title Merge</g:link>
                      </li>
                      <li class="divider"></li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'globalSync'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="globalSync">Start Global Data Sync</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'manageGlobalSources'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="manageGlobalSources">Manage Global Sources</g:link>
                      </li>
                      <li class="divider"></li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'orgsExport'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="orgsExport">Bulk Export Organisations</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'orgsImport'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="orgsImport">Bulk Load Organisations</g:link>
                      </li>
                      <li class="divider"></li>
                      <li <%= ( ( 'stats'== controllerName ) && ( 'statsHome'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="stats" action="statsHome">Statistics</g:link>
                      </li>
                        <li <%= ( ( 'jasperReports'== controllerName ) && ( 'uploadReport'==actionName ) ) ? ' class="active"' : '' %>>
                            <g:link controller="jasperReports" action="uploadReport">Upload Report Definitions</g:link></li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'triggerHousekeeping'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="triggerHousekeeping">Trigger Housekeeping</g:link>
                      </li>
                      <li <%= ( ( 'admin'== controllerName ) && ( 'initiateCoreMigration'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="admin" action="initiateCoreMigration">Initiate Core Migration</g:link>
                      </li>
                    </ul>
                  </li>

                </sec:ifAnyGranted>
                </ul>
              </sec:ifLoggedIn>
            </ul>

            <sec:ifLoggedIn>
            <ul class="nav pull-right">
              <li><a class="dlpopover" href="#"><i class="icon-search icon-white"></i></a></li>
            </ul>
            </sec:ifLoggedIn>
           

            <ul class="nav pull-right">
              <ul class="nav">
              <sec:ifLoggedIn>
                <g:if test="${user}">
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">${user.displayName} <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li <%= ( ( 'profile'== controllerName ) && ( 'index'==actionName ) ) ? ' class="active"' : '' %>>
                         <g:link controller="profile" action="index">Profile</g:link></li>
                      <li><g:link controller="logout">Logout</g:link></li>

                    </ul>
                  </li>
                </g:if>
              </sec:ifLoggedIn>
              <sec:ifNotLoggedIn>
                <li><g:link controller="myInstitutions" action="dashboard">Login</g:link></li>
              </sec:ifNotLoggedIn>
            </ul>
            </ul>
        </div>
      </div>
    </div>

   <div class="navbar-push"></div>
   <sec:ifLoggedIn>
     <g:if test="${user!=null && ( user.display==null || user.display=='' ) }">
       <div class="container">
         <bootstrap:alert class="alert-info">Your display name is not currently set in user preferences. Please <g:link controller="profile" action="index">update
            Your display name</g:link> as soon as possible.
         </bootstrap:alert>
       </div>
     </g:if>
   </sec:ifLoggedIn>


  <g:layoutBody/>

  <div id="Footer">
      <div class="navbar navbar-footer">
          <div class="navbar-inner">
              <div class="container">
                  <div>
                      <ul class="footer-sublinks nav">
                          <li><a href=${createLink(uri: '/terms-and-conditions')}>Terms & Conditions</a></li>
                          <li><a href=${createLink(uri: '/privacy-policy')}>Privacy Policy</a></li>
                          <li><a href=${createLink(uri: '/freedom-of-information-policy')}>Freedom of Information Policy</a></li>
                      </ul>
                  </div>
                  <g:set var="appVersion" value="${grailsApplication.metadata['app.version']}"/>
                  <div class="pull-right">
                      <div class="nav-collapse">
                          <ul class="nav">
                              <li class="dropdown">
                                  <a href="#"
                                     class="dropdown-toggle"
                                     data-toggle="dropdown">
                                      Tools
                                      <b class="caret"></b>
                                  </a>
                                  <ul class="dropdown-menu">
                                      <li><a href="https://www.kbplus.ac.uk/kbplus/myInstitutions/index">KB+</a></li>
                                      <li><a href="https://www.kbplus.ac.uk/demo/myInstitutions/index">KB+ Demo</a></li>
                                      <li><a href="https://www.kbplus.ac.uk/test/myInstitutions/index">KB+ Sandpit</a></li>
                                  </ul>
                              </li>
                              <li><a href="https://github.com/k-int/KBPlus/releases/tag/${appVersion}">
                              v${appVersion}</a></li>
                          </ul>
                      </div>
                  </div>
              </div>
          </div>
      </div>

      <div class="clearfix"></div>

      <div class="footer-links container">
          <div class="row">
              <div class="pull-left">
                  <a href="http://www.jisc-collections.ac.uk/"><div class="sprite sprite-jisc_collections_logo">JISC Collections</div></a>
              </div>

              <div class="pull-right">
                  <a href="http://www.kbplus.ac.uk"><div class="sprite sprite-kbplus_logo">Knowledge Base Plus</div></a>
              </div>
              
          </div>
      </div>
  </div>



  <r:script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '${grailsApplication.config.kbplus.analytics.code}']);
      <g:if test="${params.shortcode != null}">
      _gaq.push(['_setCustomVar',
            1,                     // This custom var is set to slot #1.  Required parameter.
            'Institution',         // The name acts as a kind of category for the user activity.  Required parameter.
            "${params.shortcode}", // This value of the custom variable.  Required parameter.
            2                      // Sets the scope to session-level.  Optional parameter.
         ]);
      </g:if>
      _gaq.push(['_trackPageview']);
      (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
  </r:script>

    <style type="text/css" media="screen, projection">
      @import url(//assets.zendesk.com/external/zenbox/v2.6/zenbox.css);
    </style>

    <r:script type="text/javascript">
      if (typeof(Zenbox) !== "undefined") {
        Zenbox.init({
          dropboxID:   "${grailsApplication.config.ZenDeskDropboxID?:20234067}",
          url:         "${grailsApplication.config.ZenDeskBaseURL?:'https://kbplus.zendesk.com'}",
          tabTooltip:  "Support",
          tabImageURL: "https://assets.zendesk.com/external/zenbox/images/tab_support_right.png",
          tabColor:    "#008000",
          tabPosition: "Right"
        });
      }
  </r:script>

  <r:layoutResources/>

  </body>
</html>
