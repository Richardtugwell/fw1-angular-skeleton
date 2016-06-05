##FW1 / Angular Skeleton

This is a protoype for building websites / webapps that integrate the FW/1 MVC framework with a modular AngularJS front end. It includes basic server side authentication and an authorisation scheme.

###Requirements
* [Node](https://nodejs.org/en/) 
* [Bower](http://bower.io/) for dependencies
* [Gulp](http://gulpjs.com/) for the client side Build
* [Maven](http://maven.apache.org/) to build the Lucee servlet
* [Foreman](https://github.com/ddollar/foreman) to run locally


###Quick start

To get started, run the following commands in your terminal of preference:

```bash
$ git clone https://github.com/Richardtugwell/fw1-angular-skeleton.git
$ cd fw1-angular-skeleton/client
$ gulp
$ cd ../server
$ mvn package
$ foreman start
```
NOTE: On Windows, start foreman with the following command:

```bash
$ foreman start -f Procfile.dev
```

You should now have the application up and running at [http://localhost:5000](http://localhost:5000).
Start hacking modifying as required.

By default, access to the Lucee server/web admins has remote access blocked. This can be
configured in /webroot/WEB-INF/urlrewrite.xml

###Architecture

Requests for `/<section>` return a simple Angular root template and the appropriate JS and CSS assets for application `section`. The code sits in `/client/src/apps/<section>`. The build system produces files `app.<section>.js` and `app.<section>.css`. In essence, each `/<section>` is an Angular SPA. The server side controllers that wire this together are in `/server/application/fw1/controllers/<section>.cfc`

Pure api endpoints are configured as `/api/<section>/<item>`. The controllers that orchestrate this sit in `/server/application/fw1/subsystem/api/controllers/<section>.cfc`

##Everything After Here is WIP - I'll get it completed soon!

```
├── README.md
├── client <--- FRONT END CODE AND BUILD SYSTEM (GULP)
└── server <--- SERVER SIDE CODE AND BUILD SYSTEM (MAVEN)
```
###Client
The front end code organises and manages the JS and SASS assets that are used in the application. This includes building the modular JS code into the appropriate files, and processing SASS code into CSS assets. The build system copies these to the `/server/application/webroot/assets` directory

###What is FW/1?

FW1 is a framework developed by Sean Corfield

> FW/1 - Framework One - is a family of small, lightweight, convention-over-configuration frameworks, primarily for CFML. FW/1 itself provides MVC, DI/1 provides dependency injection (a.k.a. inversion of control), and AOP/1 provides aspect-oriented programming features on top of DI/1.

[FW1 Homepage](http://framework-one.github.io/)


###Credits/Notes:
This began as a fork of Mike Sprague's [lucee-heroku-template](https://github.com/writecodedrinkcoffee/lucee-heroku-template) project.

This project uses the [cfmlprojects.org](http://cfmlprojects.org/artifacts/org/lucee/) Maven repo maintained by [Denny Valliant](https://github.com/denuno). Many thanks to Denny for his work maintaining cfmlprojects.org.

**More credits to be added here!!**


###Lucee info
Version 4.5.3.001

Lucee admin settings such as mappings and datasources are defined in application.cfc

###FW1 Notes
Version 4.0.0 Alpha

###Heroku

To deploy your site to Heroku you need to setup a free Heroku account, install the Heroku toolbelt (Suggested reading: [Getting Started with Java on Heroku](https://devcenter.heroku.com/articles/getting-started-with-java)). Then..

```bash
$ heroku apps:create [NAME]
$ git push heroku master
$ heroku open
```

You should now be looking at your app running on Heroku.

Enjoy!
