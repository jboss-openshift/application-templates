#Application Templates
This project contains OpenShift v3 application templates which support
applications based on JBoss Middleware products.

##Structure
The templates in this folder are organized by JBoss Middleware product.  Each
template is configured with the following basic parameters:
 * APPLICATION_NAME: the name of the application.  This is also used as the
   name of the docker image created by the build.
 * GIT_URI: the URI to the git project used for STI templates.
 * GIT_REF: the git reference to use when pulling the project.
 * GIT_CONTEXT_DIR: the relative directory within the project to build (if other than the root directory)
 * APPLICATION_HOSTNAME: the hostname to register for the route (for templates
   exposing services publicly, through the router).  If unset, the default, the hostnames will be of the form: `<service-name>.<project-name>.<default-domain-suffix>`, e.g. eap-app.myproject.v3.openshift.com

In addition to these basic parameters, templates utilizing databases will have
the following:
 * DB_USER: The name of the database user.
 * DB_PASSWORD: The password for the database user.
 * DB_DATABASE: The database/tablespace to connect to.
 * DB_JNDI: The JNDI name to use for datasource definitions (e.g. eap: java:jdbc/mydb or jws: jdbc/mydb)

##Common Image Repositories
The `jboss-image-streams.json` file contains __ImageStream__ definitions for all
JBoss Middleware products.  This will need to be
installed in the common `openshift` namespace (`oc create -f jboss-images-streams.json -n openshift`) before using any of the templates in these folders.  You will also need to install (into the `openshift` namespace) the database image streams supplied by OpenShift to use any of the templates that integrate with MySQL, PostgreSQL or MongoDB.

##HTTPS configuration
The majority of templates contain configuration that requires the creation of resources within your project to support HTTPS, specifically a service account and a secret that can be included into the pod as a volume.  The secrets directory contains a number of examples that can be installed into your project to allow you to test the A-MQ, EAP and JWS templates, you should replace the contents of these with data that is more appropriate for your deployments.

To install the service accounts and secrets into your project:
```
$ oc create -n myproject -f secrets
```

The following templates can be used without creating a service account or a secret: eap/eap6-basic-sti.json, webserver/jws-tomcat7-basic-sti.json and webserver/jws-tomcat8-basic-sti.json.

##Example
The easiest way to use the templates is to install them in your project, then use the _Create+_ button in the OpenShift console to create your application.  The console will prompt you for the values for all of the parameters used by the template.  To set this up for a particular template:
```
$ oc create -n openshift -f jboss-image-streams.json
$ oc create -n myproject -f webserver/jws-tomcat7-basic-sti.json
```
After executing the above, you should be able to see the template after pressing _Create+_ in your project.

Or, if you prefer the command line:
```
$ oc create -n openshift -f jboss-image-streams.json
$ oc process -n yourproject -f eap/eap6-basic-sti.json -v APPLICATION_NAME=helloworld,GIT_URI=https://github.com/jboss-developer/jboss-eap-quickstarts,GIT_REF=6.4.x,GIT_CONTEXT_DIR=helloworld | oc create -n yourproject -f -
```

You may also install the templates into the `openshift` namespace in order to make them
available to all users:
```
$ oc create -n openshift -f amq -f eap -f webserver
```
