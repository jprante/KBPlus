<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+ App Info</title>
  </head>

  <body>
    <div class="container">
      <h1>Application Info</h1>
      <table class="table table-bordered">
        <tr><td>Build Number</td><td> <g:meta name="app.buildNumber"/></td></tr>
        <tr><td>App version</td><td> <g:meta name="app.version"/></td></tr>
        <tr><td>Grails version</td><td> <g:meta name="app.grails.version"/></td></tr>
        <tr><td>Groovy version</td><td> ${GroovySystem.getVersion()}</td></tr>
        <tr><td>JVM version</td><td> ${System.getProperty('java.version')}</td></tr>
        <tr><td>Reloading active</td><td> ${grails.util.Environment.reloadingAgentEnabled}</td></tr>
        <tr><td>Build Date</td><td> <g:meta name="app.buildDate"/></td></tr>
      </table>
  
  
      <h1>Background task status</h1>
      <h2>JUSP Sync Service</h2>
      <table class="table table-bordered">
        <tr><td>Running</td><td>${juspSyncService.running}</td></tr>
        <tr><td>Completed Count</td><td>${juspSyncService.completedCount}</td></tr>
        <tr><td>New Fact Count</td><td>${juspSyncService.newFactCount}</td></tr>
        <tr><td>Total Time Elapsed</td><td>${juspSyncService.totalTime}</td></tr>
        <g:if test="${((juspSyncService.completedCount != 0) && (juspSyncService.totalTime != 0))}">
          <tr><td>Average Time Per JUSP Triple (Current/Last Run)</td><td>${juspSyncService.totalTime/juspSyncService.completedCount}</td></tr>
        </g:if>
      </table>
    </div>
  </body>
</html>