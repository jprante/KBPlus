<%@ page import="com.k_int.kbplus.Subscription" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+</title>

    <r:require modules="jeditable"/>
    <r:require module="jquery-ui"/>
  </head>
  <body>

    <div class="container">
      <ul class="breadcrumb">
        <li> <g:link controller="home">KBPlus</g:link> <span class="divider">/</span> </li>
        <li>Subscription Details</li>
      </ul>
    </div>

    <div class="container">

    ${institution?.name} Subscription Taken
       <h1><g:inPlaceEdit domain="Subscription" pk="${subscriptionInstance.id}" field="name" id="name" class="newipe">${subscriptionInstance?.name}</g:inPlaceEdit></h1>

    <div class="tabbable"> <!-- Only required for left/right tabs -->
      <dl>
        <dt>License</td>
        <dd><g:relation domain='Subscription' 
                        pk='${subscriptionInstance.id}' 
                        field='owner' 
                        class='reldataEdit'
                        id='ownerLicense'>${subscriptionInstance?.owner?.reference}</g:relation></dd>

        <g:if test="${entitlements}">
          <g:form action="subscriptionBatchUpdate" params="${[shortcode:params.shortcode, id:subscriptionInstance?.id]}">
            <dt>Entitlements ( ${offset+1} to ${offset+(entitlements?.size())} of ${num_sub_rows} )</td>
            <dd>
              <g:set var="counter" value="${offset+1}" />
              <table  class="table table-striped table-bordered table-condensed">
                <tr>
                  <th></th>
                  <th>#</th>
                  <th>Title</th>
                  <th>ISSN</th>
                  <th>eISSN</th>
                  <th>Core</th>
                  <th>Start Date</th>
                  <th>End Date</th>
                  <th>Embargo</th>
                  <th>Content URL</th>
                  <th>Coverage</th>
                  <th>Docs</th>
                  <th>JUSP</th>
                </tr>  
                <tr>  
                  <th colspan="5"><input type="Submit" value="Apply Batch Changes"/></th>
                  <th><span id="entitlementBatchEdit" class="entitlementBatchEdit"></span><input type="hidden" name="bulk_core" id="bulk_core"/></th>
                  <th><span>edit</span> <input name="bulk_start_date" type="hidden" class="hdp" /></th>
                  <th><span>edit</span> <input name="bulk_end_date" type="hidden" class="hdp" /></th>
                  <th><span id="embargoBatchEdit" class="embargoBatchEdit"></span><input type="hidden" name="bulk_embargo" id="bulk_embargo"></th>
                  <th colspan="4"></th>
                </tr>
                <g:each in="${entitlements}" var="ie">
                  <tr>
                    <td><input type="checkbox" name="_bulkflag.${ie.id}"/></td>
                    <td>${counter++}</td>
                    <td><g:link controller="titleInstance" action="show" id="${ie.tipp.title.id}">${ie.tipp.title.title}</g:link></td>
                    <td>${ie?.tipp?.title?.getIdentifierValue('ISSN')}</td>
                    <td>${ie?.tipp?.title?.getIdentifierValue('eISSN')}</td>
                    <td><g:refdataValue val="${ie.coreTitle}" 
                                        domain="IssueEntitlement" 
                                        pk="${ie.id}" 
                                        field="coreTitle" 
                                        cat="isCoreTitle"
                                        class="coreedit"/></td>
                    <td>
                        <span><g:formatDate format="dd MMMM yyyy" date="${ie.startDate}"/></span>
                        <input id="IssueEntitlement:${ie.id}:startDate" type="hidden" class="dp1" />
                    </td>
                    <td><span><g:formatDate format="dd MMMM yyyy" date="${ie.endDate}"/></span>
                        <input id="IssueEntitlement:${ie.id}:endDate" type="hidden" class="dp2" />
                    </td>
                    <td><g:inPlaceEdit domain="IssueEntitlement" pk="${ie.id}" field="embargo" id="embargo" class="newipe">${ie.embargo}</g:inPlaceEdit></td>
                    <td>${ie.tipp?.platform?.primaryUrl}</td>
                    <td>${ie.coverageDepth}<br/>${ie.coverageNote}</td>  
                    <td>docs</td>  
                    <td>JUSP</td>
                  </tr>
                </g:each>
              </table>
            </dd>
          </g:form>
        </g:if>
        <dt>Org Links</td>
        <dd>
          <ul>
            <g:each in="${subscriptionInstance.orgRelations}" var="or">
              <li>${or.org.name}:${or.roleType?.value}</li>
            </g:each>
          <ul>
        </dd>
      </dl>
    </div>

    <div class="paginateButtons" style="text-align:center">
      <g:if test="${entitlements}" >
        <span><g:paginate controller="myInstitutions" 
                          action="subscriptionDetails" 
                          params="${params}" next="Next" prev="Prev" 
                          max="15" 
                          total="${num_sub_rows}" /></span>
      </g:if>
    </div>

    </div>
    <script language="JavaScript">
      $(document).ready(function() {

        var datepicker_config = {
          buttonImage: '../../../images/calendar.gif',
          buttonImageOnly: true,
          changeMonth: true,
          changeYear: true,
          showOn: 'both',
          onSelect: function(dateText, inst) { 
            var elem_id = inst.input[0].id;
            $.ajax({url: '<g:createLink controller="ajax" action="genericSetValue" absolute="true"/>?elementid='+
                             elem_id+'&value='+dateText+'&dt=date&idf=MM/dd/yyyy&odf=dd MMMM yyyy',
                   success: function(result){inst.input.parent().find('span').html(result)}
                   });
          }
        };

        $("div dl dd table tr td input.dp1").datepicker(datepicker_config);
        $("div dl dd table tr td input.dp2").datepicker(datepicker_config);

        $("input.hdp").datepicker({
          buttonImage: '../../../images/calendar.gif',
          buttonImageOnly: true,
          changeMonth: true,
          changeYear: true,
          showOn: 'both',
          onSelect: function(dateText, inst) {
            inst.input.parent().find('span').html(dateText)
          }
        });

        $('span.newipe').editable('<g:createLink controller="ajax" action="genericSetValue" absolute="true"/>', {
          type      : 'textarea',
          cancel    : 'Cancel',
          submit    : 'OK',
          id        : 'elementid',
          rows      : 3,
          tooltip   : 'Click to edit...'
        });

        $('span.entitlementBatchEdit').editable(function(value, settings) { 
          $("#bulk_core").val(value);
          return(value);          
        },{ data:{'true':'true','false':'false'}, type:'select',cancel:'Cancel',submit:'OK', rows:3, tooltop:'Click to edit...', width:'100px'});

        $('span.embargoBatchEdit').editable(function(value, settings) { 
          $("#bulk_embargo").val(value);
          return(value);
        },{type:'textarea',cancel:'Cancel',submit:'OK', rows:3, tooltop:'Click to edit...', width:'100px'});

        $('td span.coreedit').editable('<g:createLink controller="ajax" action="genericSetValue" absolute="true"/>', {
           data   : {'true':'true', 'false':'false'},
           type   : 'select',
           cancel : 'Cancel',
           submit : 'OK',
           id     : 'elementid',
           tooltip: 'Click to edit...'
         });

         $('dd span.reldataEdit').editable('<g:createLink controller="ajax" params="${[resultProp:'reference']}"action="genericSetRel" absolute="true"/>', {
           loadurl: '<g:createLink controller="MyInstitutions" params="${[shortcode:params.shortcode]}" action="availableLicenses" absolute="true"/>',
           type   : 'select',
           cancel : 'Cancel',
           submit : 'OK',
           id     : 'elementid',
           tooltip: 'Click to edit...',
           callback : function(value, settings) {
           }
         });

         var checkEmptyEditable = function() {
           $('.ipe, .refdataedit, .fieldNote, .reldataEdit').each(function() {
             if($(this).text().length == 0) {
               $(this).addClass('editableEmpty');
             } else {
               $(this).removeClass('editableEmpty');
             }
           });
         }


      });
    </script>
  </body>
</html>
