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
   exposing services publicly, through the router).

In addition to these basic parameters, templates utilizing databases will have
the following:
 * DB_USER: The name of the database user.
 * DB_PASSWORD: The password for the database user.
 * DB_DATABASE: The database/tablespace to connect to.
 * DB_JNDI: The JNDI name to use for datasource definitions (e.g. eap: java:jdbc/mydb or jws: jdbc/mydb)

##Common Image Repositories
The `jboss-image-streams.json` file contains __ImageStream__ definitions for all
JBoss Middleware products and supported database images.  This will need to be
installed (`osc create -f jboss-images-streams.json -n <namespace>`)
before using any of the templates in these folders.

##Example
The easiest way to use the templates is to install them in your project, then use the _Create+_ button in the OpenShift console to create your application.  The console will prompt you for the values for all of the parameters used by the template.  To set this up for a particula template:
```
$ osc create -n myproject -f jboss-image-streams.json
$ osc create -n myproject -f webserver/jws-tomcat7-basic-sti.json
```
After executing the above, you should be able to see the template after pressing _Create+_ in your project.

Or, if you prefer the command line:
```
$ osc create -n yourproject -f jboss-image-streams.json
$ osc process -n yourproject -f eap/eap6-basic-sti.json -v APPLICATION_NAME=helloworld,APPLICATION_HOSTNAME=helloworld.yourproject.local,GIT_URI=https://github.com/jboss-developer/jboss-eap-quickstarts,GIT_REF=6.4.x,GIT_CONTEXT_DIR=helloworld | osc create -n yourproject -f -
```
