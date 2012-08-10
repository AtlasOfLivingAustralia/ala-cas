%{--
  - Copyright (C) 2012 Atlas of Living Australia
  - All Rights Reserved.
  -
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  -
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
  --}%
<!doctype html>
<html>
<head>
    <meta name="layout" content="ala2"/>
    <title>Species List</title>
</head>
<body class="species">
<div id="content">
    <header id="page-header">
        <div class="inner">
            <nav id="breadcrumb">
                <ol>
                    <li><a href="http://www.ala.org.au">Home</a></li>
                    <li class="last">Species Lists</li>
                </ol>
            </nav>
            <h1>Species Lists</h1>
        </div><!--inner-->
    </header>
    <div class="inner">
        <div id="section" class="col-wide">

            <a class="button orange" title="Add Species List" href="${request.contextPath}/speciesList/upload">Add Species List</a>
            <a class="button orange" title="My Lists" href="${request.contextPath}/speciesList/list">My Lists</a>

        <g:if test="${lists && total>0}">
            <p>All Available Species Lists:</p>
            <g:render template="/speciesList"/>
            %{--<table>--}%
                %{--<thead>--}%
                %{--<tr>--}%
                    %{--<td>List Name</td>--}%
                    %{--<td>Owner</td>--}%
                    %{--<td>Number of Items</td>--}%
                %{--</tr>--}%
                %{--</thead>--}%
                %{--<tbody>--}%
                    %{--<g:each in="${lists}" var="list" status="i">--}%
                        %{--<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">--}%
                            %{--<td>${fieldValue(bean: list, field: "listName")}</td>--}%
                            %{--<td>${fieldValue(bean: list, field: "firstName")} ${fieldValue(bean: list, field: "surname")}</td>--}%
                            %{--<td>${list.items.size()}</td>--}%
                        %{--</tr>--}%
                    %{--</g:each>--}%
                %{--</tbody>--}%
            %{--</table>--}%
            %{--<div class="pagination">--}%
                %{--<g:paginate total="${total}" action="showList"  />--}%
            %{--</div>--}%
        </g:if>
        <g:else>
            <p>There are no Species Lists available</p>
        </g:else>
        %{--</div> <!-- results -->--}%
    </div>
    </div>
</div> <!-- content div -->
</body>
</html>