<%@ page session="true" %><%@
page pageEncoding="UTF-8" %><%@
page contentType="text/html; charset=UTF-8" %><%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@
taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
taglib uri="/tld/ala.tld" prefix="ala" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description" content="The Atlas of Living Australia provides tools to enable users of biodiversity information to find, access, combine and visualise data on Australian plants and animals" />

<title>Login | Atlas of Living Australia</title>

    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script src="https://www.ala.org.au/commonui-bs2/js/application.js" type="text/javascript" ></script>
    <script src="https://www.ala.org.au/commonui-bs2/js/bootstrap.js" type="text/javascript" ></script>
    <link href="https://www2.ala.org.au/commonui-bs2/css/bootstrap.min.css" type="text/css" rel="stylesheet" media="screen, projection" />
    <link href="https://www2.ala.org.au/commonui-bs2/css/bootstrap-responsive.min.css" type="text/css" rel="stylesheet" media="screen, projection" />
    <link href="https://www2.ala.org.au/commonui-bs2/css/ala-styles.css" type="text/css" rel="stylesheet" media="screen, projection" />
    <link href="css/font-awesome-4.3.0.css" type="text/css" rel="stylesheet" media="all" />
    <link type="text/css" rel="stylesheet" href="<spring:theme code="standard.custom.css.file" />" />

</head>
<body id="cas" class="">
<div id="wrapper">
<c:if test="${empty param.format || param.format != 'minimal'}">
<ala:bannerMenu  returnUrlPath="http://www.ala.org.au"/>
    <div id="content" class="container">
        <header id="page-header">
        <div class="row-fluid">
            <div id="breadcrumb" class="span12">
                <ol class="breadcrumb">
                    <li>
                        <a href="http://www.ala.org.au">Home</a>
                        <span class=" icon icon-arrow-right"></span>
                    </li>
                    <li class="current">Authentication</li>
                </ol>
            </div>
</c:if>
