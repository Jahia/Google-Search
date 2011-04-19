<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>

<c:set var="googleAPIKey" value="${renderContext.site.properties.googleAPIKey.string}"/>
<c:if test="${empty googleAPIKey}">
    <c:set var="googleAPIKey"
           value="ABQIAAAAclWmYv4CIiPrCyiXoeH6jxQlR9cThfCpC2LaA7nNm9iQWQzvXRQCy4HBu32cTDNvTVqOkVLGLiMHNA"/>
    <c:if test="${renderContext.editMode}">
        <fmt:message key="setApiKey"/>
        <%--
        <form name="jcrQueryForm" action="">
            <input id="googleAPIKey" type="text" name="googleAPIKey" value="" size="30"/>
            <input id="submitButton" type="submit" name="submitButton"/>
        </form>
        <script type="text/javascript">


            function doQuery() {
                $.ajax({
                    url : "${url.base}${renderContext.site.path}",
                    type : "PUT",
                    dataType : "json",
                    //data : { "jcr:mixinTypes": "jnt:googleAPIKey",googleAPIKey: $("input#googleAPIKey").val() },
                    data : { "jcr:mixinTypes": "jnt:googleAPIKey" },
                    success : function(data) {
                        alert("<fmt:message key='googleAPIKey.saved'/>");
                        //logout();
                    }});

            }

            $(document).ready(function() {
            });

            $("#submitButton").click(function () {
                doQuery();
                return false;
            })
        </script>
        --%>
    </c:if>
</c:if>

<script src="https://www.google.com/jsapi?key=${googleAPIKey}"
        type="text/javascript"></script>
<script language="Javascript" type="text/javascript">
    //<![CDATA[

    google.load("search", "1", {"language" : "${currentResource.locale}"});

    function OnLoad() {
        // Create a search control
        var searchControl = new google.search.SearchControl();

        var options = new google.search.SearcherOptions();
        options.setExpandMode(google.search.SearchControl.EXPAND_MODE_OPEN);

        // Add in a full set of searchers
        var siteSearch = new google.search.WebSearch();
        siteSearch.setUserDefinedLabel("<fmt:message key='siteSearch.label'/>");
        siteSearch.setUserDefinedClassSuffix("siteSearch");
        siteSearch.setSiteRestriction("${renderContext.site.serverName}");

        searchControl.addSearcher(siteSearch, options);

        var drawOptions = new GdrawOptions();
        drawOptions.setDrawMode(GSearchControl.DRAW_MODE_LINEAR);


        // Tell the searcher to draw itself and tell it where to attach
        searchControl.draw(document.getElementById("${currentNode.UUID}"), drawOptions);

        // Execute an inital search
        searchControl.execute("");
    }
    google.setOnLoadCallback(OnLoad);

    //]]>
</script>
<template:addResources type="css" resources="googleSearch.css"/>
<template:addResources type="javascript" resources="jquery.min.js"/>
<c:choose>
    <c:when test="${!renderContext.editMode}">
        <div id="${currentNode.UUID}"><fmt:message key="loading"/></div>
    </c:when>
    <c:otherwise>

    </c:otherwise>
</c:choose>

