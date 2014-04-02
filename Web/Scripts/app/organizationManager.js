﻿/***
 * Service: dataContext 
 *
 * Handles all persistence and creation/deletion of app entities
 * using BreezeJS.
 *
 ***/
(function () {
    'use strict';

    var serviceId = 'organizationManager';
    angular.module('main')
        .factory(serviceId, ['dataContext', 'logger', organizationManager]);

    function organizationManager(dataContext, logger) {

        // Logger
        logger = logger.forSource(serviceId);
        var logError = logger.logError;
        var logSuccess = logger.logSuccess;
        var logWarning = logger.logWarning;

        // To determine whether the data will be fecthed from server or local
        var minimumDate = new Date(0);
        var fetchedOn = minimumDate;

        // Service methods (alphabetically)
        var service = {
            createOrganization: createOrganization,
            deleteOrganization: deleteOrganization,
            getChanges: getChanges,
            getChangesCount: getChangesCount,
            getLicenseSet: getLicenseSet,
            getOrganizationSet: getOrganizationSet,
            getSectorSet: getSectorSet,
            getOrganization: getOrganization,
            hasChanges: hasChanges,
            rejectChanges: rejectChanges,
            saveChanges: saveChanges
        };

        return service;

        /*** Implementations ***/

        function createOrganization(organization) {
            return dataContext.manager.createEntity('Organization', organization);
        }

        function deleteOrganization(organization) {
            organization.entityAspect.setDeleted();
        }

        function getChanges() {
            return dataContext.getChanges();
        }

        function getChangesCount() {
            return dataContext.getChangesCount();
        }

        function getLicenseSet() {
            var query = breeze.EntityQuery
                .from("License");

            // Fetch the data from server, in case if it's not fetched earlier or forced
            // var fetchFromServer = fetchedOn === minimumDate || forceRefresh;
            var fetchFromServer = true;

            // Prepare the query
            if (fetchFromServer) { // From remote
                query = query.using(breeze.FetchStrategy.FromServer)
                // fetchedOn = new Date();
            }
            else { // From local
                query = query.using(breeze.FetchStrategy.FromLocalCache)
            }

            return dataContext.manager.executeQuery(query)
                .then(success).catch(failed);

            function success(response) {
                // count = response.results.length;
                // logSuccess('Got ' + count + ' license(s)', response, true);
                return response.results;
            }

            function failed(error) {
                var message = error.message || "License query failed";
            }
        }

            function getOrganizationSet(forceRefresh) {

                var count;
                if (forceRefresh) {
                    if (dataContext.hasChanges()) {
                        count = dataContext.getChangesCount();
                        dataContext.rejectChanges(); // undo all unsaved changes!
                        logWarning('Discarded ' + count + ' pending change(s)', null, true);
                    }
                }

                var query = breeze.EntityQuery
                    .from("Organization")
                    .expand(["Sector", "License"]);

                // Fetch the data from server, in case if it's not fetched earlier or forced
                var fetchFromServer = fetchedOn === minimumDate || forceRefresh;

                // Prepare the query
                if (fetchFromServer) { // From remote
                    query = query.using(breeze.FetchStrategy.FromServer)
                    fetchedOn = new Date();
                }
                else { // From local
                    query = query.using(breeze.FetchStrategy.FromLocalCache)
                }

                return dataContext.manager.executeQuery(query)
                    .then(success).catch(failed);

                function success(response) {
                    count = response.results.length;
                    logSuccess('Got ' + count + ' organization(s)', response, true);
                    return response.results;
                }

                function failed(error) {
                    var message = error.message || "Organization query failed";
                    logError(message, error, true);
                }
            }

            function getSectorSet() {
                var query = breeze.EntityQuery
                    .from("Sector");

                // Fetch the data from server, in case if it's not fetched earlier or forced
                // var fetchFromServer = fetchedOn === minimumDate || forceRefresh;
                var fetchFromServer = true;

                // Prepare the query
                if (fetchFromServer) { // From remote
                    query = query.using(breeze.FetchStrategy.FromServer)
                    // fetchedOn = new Date();
                }
                else { // From local
                    query = query.using(breeze.FetchStrategy.FromLocalCache)
                }

                return dataContext.manager.executeQuery(query)
                    .then(success).catch(failed);

                function success(response) {
                    // count = response.results.length;
                    // logSuccess('Got ' + count + ' sector(s)', response, true);
                    return response.results;
                }

                function failed(error) {
                    var message = error.message || "Sector query failed";
                }
            }

            function getOrganization(organizationId, forceRefresh) {
                return dataContext.manager.fetchEntityByKey("Organization", organizationId, !forceRefresh)
                    .then(success).catch(failed);

                function success(result) {

                    return result.entity.entityAspect.loadNavigationProperty("License")
                        .then(function (licenseData) {
                            return result.entity.entityAspect.loadNavigationProperty("Sector")
                                .then(function (sectorData) {
                                    return result.entity;
                                });
                        });

                    // TODO Catch cases?

                }

                function failed(error) {
                    var message = error.message || "getOrganization query failed";
                    logError(message, error, true);
                }
            }

            function hasChanges() {
                return dataContext.hasChanges();
            }

            function rejectChanges() {
                dataContext.rejectChanges();
            }

            function saveChanges() {
                return dataContext.saveChanges();
            }
        }
    })();