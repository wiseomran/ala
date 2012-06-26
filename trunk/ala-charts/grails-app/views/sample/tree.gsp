<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chart sampler</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'charts.css')}" />
    <script type="text/javascript" language="javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" language="javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
    <script type="text/javascript" language="javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://jquery-jsonp.googlecode.com/files/jquery.jsonp-2.1.4.min.js"></script>
    <style>
    input[type=radio] {margin-left: 15px;}
    h1 {color: #718804 }
    </style>
    <r:require module="charts"/>
    <r:layoutResources/>
</head>
<body style="padding: 20px;">
<h1>Tree sampler</h1>

<div id="tree"></div>

<r:script type="text/javascript">
    var biocacheServicesUrl = "http://biocache.ala.org.au/ws";
    var biocacheWebappUrl = "http://biocache.ala.org.au/";
    var serverUrl = "http://localhost:8080/ala-charts";
    var taxonomyTreeOptions = {
      /* base url of the biocache ws*/
      biocacheServicesUrl: biocacheServicesUrl,
      /* base url of the biocache webapp*/
      biocacheWebappUrl: biocacheWebappUrl,
      serverUrl: serverUrl,
      //theme: 'default',
      icons: true,
      title: '',
      /* the id of the div to create the charts in - defaults is 'charts' */
      targetDivId: "tree",
      /* a query to set the scope of the records */
      query: "*:*"
    };

    initTaxonTree(taxonomyTreeOptions);

</r:script>
<r:layoutResources/>
</body>
</html>