﻿<!DOCTYPE html>
<html data-ng-app="main">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <title data-ng-bind="'Wealth Economy' + (viewTitle !== '' ? ' - ' + viewTitle : '')"></title>
    <base href="/" />

    <!-- External CSS -->
    <link href="/bower_components/bootstrap/dist/css/bootstrap.min.css?v=0.42" rel="stylesheet" />
    <link href="/bower_components/font-awesome/css/font-awesome.min.css?v=0.42" rel="stylesheet" />
    <link href="/bower_components/breeze-client-labs/breeze.directives.css?v=0.42" rel="stylesheet" />
    <link href="/bower_components/toastr/toastr.min.css?v=0.42" rel="stylesheet" />
    <link href="/bower_components/bootstrap-social/bootstrap-social.css?v=0.42" rel="stylesheet" />

    <!-- Internal CSS -->
    <link href="/css/site.css?v=0.37" rel="stylesheet" />
    <link href="/app/directives/resourcePoolEditor/resourcePoolEditor.css?v=0.37" rel="stylesheet" />

    <!-- jQuery -->
    <script src="/bower_components/jquery/dist/jquery.min.js?v=0.42"></script>

    <!-- Modernizr - TODO Not in use at the moment -->
    <!--<script src="/Scripts/modernizr-2.8.3.js"></script>-->

    <!-- Google Analytics -->
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-62498767-2', 'auto');
        ga('send', 'pageview');

    </script>
</head>
<body data-ng-app="main" data-ng-controller="mainController as vm">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="/" class="navbar-brand">
                    <!--<span><img src="/images/forCrowd_logo_20x20.jpg?v=0.29.2" /></span>-->
                    Wealth Economy
                </a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown hide" data-uib-dropdown>
                        <a href="" class="dropdown-toggle" data-uib-dropdown-toggle>Content <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/content/overview">Overview</a></li>
                            <li><a href="/content/technologies">Technologies</a></li>
                        </ul>
                    </li>
                    <li class="dropdown hide" data-uib-dropdown data-ng-show="vm.isAuthenticated()">
                        <a href="" class="dropdown-toggle" data-uib-dropdown-toggle>Manage <b class="caret"></b></a>
                        <!-- Manage Menu - Generated -->
                        <script src="/app/includes/manageMenu.js?v=0.37"></script>
                    </li>
                    <li>
                        <a href="/resourcePool">CMRP</a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown" data-uib-dropdown data-ng-if="vm.isAuthenticated()">
                        <a href="" class="dropdown-toggle" data-uib-dropdown-toggle><span data-ng-bind="vm.currentUserText()"></span><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/account/accountEdit">Edit</a></li>
                            <li><a href="/account/changeEmail">Change email</a></li>
                            <li><a href="/account/confirmEmail" data-ng-if="!vm.currentUser.EmailConfirmed">Confirm email</a></li>
                            <li data-ng-if="vm.hasPassword()"><a href="/account/changePassword">Change password</a></li>
                            <li data-ng-if="!vm.hasPassword()"><a href="/account/addPassword">Add password</a></li>
                            <li><a href="" data-ng-click="vm.logout()">Logout</a></li>
                        </ul>
                    </li>
                    <li data-ng-if="!vm.isAuthenticated()">
                        <div class="navbar-text nofloat">
                            <a href="/account/register">Register</a>
                            &nbsp;
                            <a href="/account/login">Login</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">

        <div data-ng-view></div>

        <hr />
        <footer>
            <p class="small">
                <span data-ng-bind="vm.applicationInfo.CurrentVersionText"></span>
            </p>
            <p class="brandLink">
                <a href="http://forcrowd.org" target="_blank">
                    <img src="/images/forCrowd_logo_34x34.jpg?v=0.29.2" class="brandLinkImage" />
                    <span class="brandLinkText">
                        <span class="brandLinkPrimary">forCrowd</span><br />
                        <span class="brandLinkSecondary">FOUNDATION</span>
                    </span>
                </a>
            </p>
        </footer>
    </div>

    <!--<script src="/Scripts/bootstrap.min.js?v=0.37"></script>-->
    <!-- Is this useful, since bootstrap.min.js is commented out? -->
    <script src="/bower_components/respond/dest/respond.min.js?v=0.42"></script>
    
    <script src="/bower_components/datajs/datajs.min.js?v=0.42"></script>
    <script src="/bower_components/toastr/toastr.min.js?v=0.42"></script>

    <script src="/bower_components/angular/angular.min.js?v=0.42"></script>
    <script src="/bower_components/angular-route/angular-route.min.js?v=0.42"></script>
    <script src="/bower_components/angular-sanitize/angular-sanitize.min.js?v=0.42"></script>

    <!-- Angular UI -->
    <script src="/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js?v=0.42"></script>

    <!-- breeze -->
    <script src="/bower_components/breeze-client/build/breeze.min.js?v=0.42"></script>
    <script src="/bower_components/breeze-client/build/adapters/breeze.bridge.angular.js?v=0.42"></script>
    <script src="/bower_components/breeze-client-labs/breeze.directives.js?v=0.42"></script>

    <!-- Highcharts -->
    <script src="/bower_components/highcharts/highcharts.js?v=0.42"></script>
    <script src="/bower_components/highcharts-ng/dist/highcharts-ng.min.js?v=0.42"></script>

    <!-- Main -->
    <script src="/app/main.js?v=0.39"></script>
    <script src="/app/configs/serviceAppUrl.js?v=0.42"></script>
    <script src="/app/logger.js?v=0.40"></script>
    <script src="/app/route.js?v=0.42"></script>
    <script src="/app/authorization.js?v=0.29"></script>
    <script src="/app/exceptionHandlerExtension.js?v=0.42"></script>

    <!-- Entities -->
    <script src="/app/entities/ResourcePool.js?v=0.40"></script>
    <script src="/app/entities/Element.js?v=0.40"></script>
    <script src="/app/entities/ElementCell.js?v=0.40"></script>
    <script src="/app/entities/ElementField.js?v=0.40"></script>
    <script src="/app/entities/ElementItem.js?v=0.40"></script>
    <script src="/app/entities/User.js?v=0.41.3"></script>
    <script src="/app/entities/UserElementCell.js?v=0.40"></script>
    <script src="/app/entities/Enums.js?v=0.37"></script>
    <script src="/app/entities/LocationItem.js?v=0.38"></script>

    <!-- breezeJS -->
    <script src="/app/entityManagerFactory.js?v=0.42"></script>
    <script src="/app/dataContext.js?v=0.41.3"></script>
    <script src="/app/factories/mainFactory.js?v=0.42"></script>

    <!-- Manage Scripts - Generated (Factories, Controllers) -->
    <script src="/app/includes/manageScripts.js?v=0.37"></script>

    <!-- Factory extensions -->
    <script src="/app/factories/userFactory.js?v=0.42"></script>
    <script src="/app/factories/resourcePoolFactory.js?v=0.40"></script>

    <!-- Content -->
    <script src="/app/controllers/content/mainController.js?v=0.42.1"></script>
    <script src="/app/controllers/content/introductionController.js?v=0.41.3"></script>
    <script src="/app/controllers/content/basicsController.js?v=0.41.3"></script>
    <script src="/app/controllers/content/sectorIndexSampleController.js?v=0.37"></script>
    <script src="/app/controllers/content/knowledgeIndexSampleController.js?v=0.37"></script>
    <script src="/app/controllers/content/totalCostIndexSampleController.js?v=0.37"></script>
    <script src="/app/controllers/content/fairShareIndexSampleController.js?v=0.37"></script>
    <script src="/app/controllers/content/indexesPieSampleController.js?v=0.37"></script>
    <script src="/app/controllers/content/resourcePoolRateSampleController.js?v=0.29"></script>
    <script src="/app/controllers/content/closingNotesController.js?v=0.41.3"></script>

    <!-- Resource Pool -->
    <script src="/app/controllers/resourcePool/resourcePoolEditController.js?v=0.41.3"></script>
    <script src="/app/controllers/resourcePool/resourcePoolListController.js?v=0.37"></script>
    <script src="/app/controllers/resourcePool/resourcePoolViewController.js?v=0.38"></script>

    <!-- Account -->
    <script src="/app/controllers/account/registerController.js?v=0.42"></script>
    <script src="/app/controllers/account/loginController.js?v=0.42.1"></script>
    <script src="/app/controllers/account/externalLoginController.js?v=0.41.3"></script>
    <script src="/app/controllers/account/accountEditController.js?v=0.41.2"></script>
    <script src="/app/controllers/account/changeEmailController.js?v=0.41.2"></script>
    <script src="/app/controllers/account/changePasswordController.js?v=0.41.2"></script>
    <script src="/app/controllers/account/addPasswordController.js?v=0.41.2"></script>
    <script src="/app/controllers/account/confirmEmailController.js?v=0.41.3"></script>

    <!-- Directives -->
    <script src="/app/directives/resourcePoolEditor/resourcePoolEditor.js?v=0.41.3"></script>

    <!-- Filters -->
    <script src="/app/filters/angular-enum.js?v=0.37"></script>
    <script src="/app/filters/angular-numberSymbol.js?v=0.36.1"></script>
    <script src="/app/filters/angular-percentage.js?v=0.22"></script>

</body>
</html>