<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+ Packages</title>
  </head>

  <body>


    <div class="container">
      <ul class="breadcrumb">
        <li><g:link controller="home" action="index">Home</g:link> <span class="divider">/</span></li>
        <li><g:link controller="packageDetails" action="index">All Packages</g:link></li>
      </ul>
    </div>



    <div class="container">
      <g:form action="index" method="get" params="${params}">
      <input type="hidden" name="offset" value="${params.offset}"/>

      <div class="row">
        <div class="span12">
          <div class="well form-horizontal">
            Package Name: <input name="pkgname" value="${params.pkgname}"/>
            Sort: <select name="sorting">
                    <option ${params.sorting=='_score' ? 'selected' : ''} value="_score">Score</option>
                    <option ${params.sorting=='sortname' ? 'selected' : ''} value="sortname">Package Name</option>
                    <option ${params.sorting=='lastModified' ? 'selected' : ''} value="lastModified">Last Modified</option>
                  </select>
            Order: <select name="order" value="${params.order}">
                    <option ${params.order=='desc' ? 'selected' : ''} value="desc">Descending</option>
                    <option ${params.order=='asc' ? 'selected' : ''} value="asc">Ascending</option>
                  </select>
            <button type="submit" name="search" value="yes">Search</button>
          </div>
        </div>
      </div>
      </g:form>

      <div class="row">
        <div class="span2">
          <div class="well">
              <g:each in="${facets}" var="facet">
                <h5><g:message code="facet.so.${facet.key}" default="${facet.key}" /></h5>
                    <g:each in="${facet.value}" var="fe">
                      <g:set var="facetname" value="fct:${facet.key}:${fe.display}" />
                      <div><g:checkBox class="pull-right" name="${facetname}" value="${params[facetname]}" />${fe.display} (${fe.count})</div>
                    </g:each>
              </g:each>
          </div>
        </div>
        <div class="span10">
          <div class="well">
             <g:if test="${hits}" >
                <div class="paginateButtons" style="text-align:center">
                    <g:if test=" ${params.int('offset')}">
                   Showing Results ${params.int('offset') + 1} - ${hits.totalHits < (params.int('max') + params.int('offset')) ? hits.totalHits : (params.int('max') + params.int('offset'))} of ${hits.totalHits}
                  </g:if>
                  <g:elseif test="${hits.totalHits && hits.totalHits > 0}">
                      Showing Results 1 - ${hits.totalHits < params.int('max') ? hits.totalHits : params.int('max')} of ${hits.totalHits}
                  </g:elseif>
                  <g:else>
                    Showing ${hits.totalHits} Results
                  </g:else>
                </div>

                <div id="resultsarea">
                  <table class="table table-bordered table-striped">
                    <thead>
                      <tr><th>Package Name</th><th>Consortium</th>
                          <th>Start Date</th>
                          <th>End Date</th>
                          <th>Last Modified</th></tr>
                    </thead>
                    <tbody>
                      <g:each in="${hits}" var="hit">
                        <tr>
                          <td><g:link controller="packageDetails" action="show" id="${hit.source.dbId}">${hit.source.name}</g:link>
                              <!--(${hit.score})-->
                              <span>(${hit.source.titleCount?:'Unknown number of'} titles)</span>
                              </td>
                          <td>${hit.source.consortiaName}</td>
                          <td>${hit.source.startDate}</td>
                          <td>${hit.source.endDate}</td>
                          <td>${hit.source.lastModified}</td>
                        </tr>
                      </g:each>
                    </tbody>
                  </table>
                </div>
             </g:if>
             <div class="paginateButtons" style="text-align:center">
                <g:if test="${hits}" >
                  <span><g:paginate controller="packageDetails" action="index" params="${params}" next="Next" prev="Prev" total="${hits.totalHits}" /></span>
                </g:if>
              </div>
          </div>
        </div>
      </div>
    </div>
    <!-- ES Query: ${es_query} -->
  </body>
</html>
