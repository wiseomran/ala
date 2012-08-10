
/******* Change this stuff for your project *******/
appName = 'phylojive'
serverName='http://localhost:8080'
contextPath='/phylojive'
security.cas.uriFilterPattern = ''
/******* End of change this stuff for your project *******/

/******* ALA standard config ************/
headerAndFooter.baseURL = "http://www2.ala.org.au/commonui"
security.cas.casServerName = 'https://auth.ala.org.au'
security.cas.uriFilterPattern = ''
security.cas.uriExclusionFilterPattern = '/images.*,/css.*,/js.*'
security.cas.loginUrl = 'https://auth.ala.org.au/cas/login'
security.cas.logoutUrl = 'https://auth.ala.org.au/cas/logout'
security.cas.casServerUrlPrefix = 'https://auth.ala.org.au/cas'
security.cas.bypass = false
ala.baseURL = "http://www.ala.org.au"
bie.baseURL = "http://bie.ala.org.au"
bie.searchPath = "/search"
grails.project.groupId = au.org.ala // change this to alter the default package name and Maven publishing destination
identifyLifeUrl = "http://ala-ilife2.it.csiro.au/ds/search/scores/"

/******* End of ALA standard config ************/

grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        serverName = 'http://nickdos.ala.org.au:8080'
        grails.logging.jul.usebridge = true
        grails.serverURL = 'http://nickdos.ala.org.au:8080/' + appName
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
        grails.serverURL = 'http://localhost:8080/' + appName
    }
}

// log4j configuration
// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    appenders {

        console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"), threshold: org.apache.log4j.Level.DEBUG
//        rollingFile name: "dev2", layout: pattern(conversionPattern: "[POSTIE] %c{2} %m%n"), maxFileSize: 1024, file: "/tmp/postie.log", threshold: org.apache.log4j.Level.DEBUG

        environments {
            production {
                rollingFile name: "tomcatLog", maxFileSize: 102400000, file: "/var/log/tomcat6/phylojive.log", threshold: org.apache.log4j.Level.DEBUG, layout: pattern(conversionPattern: "%d %-5p [%c{1}] %m%n")
                'null' name: "stacktrace"
            }
            development {
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"), threshold: org.apache.log4j.Level.DEBUG
                rollingFile name: "tomcatLog", maxFileSize: 102400000, file: "/tmp/phylojive.log", threshold: org.apache.log4j.Level.DEBUG, layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n")
                'null' name: "stacktrace"
            }
            test {
                rollingFile name: "tomcatLog", maxFileSize: 102400000, file: "/tmp/phylojive-test.log", threshold: org.apache.log4j.Level.DEBUG, layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n")
                'null' name: "stacktrace"
            }
        }
    }

    root {
        // change the root logger to my tomcatLog file
        error 'tomcatLog'
        warn 'tomcatLog'
        info 'tomcatLog'
        debug 'tomcatLog', 'stdout'
        additivity = true
    }

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
            'org.codehaus.groovy.grails.web.pages', //  GSP
            'org.codehaus.groovy.grails.web.sitemesh', //  layouts
            'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
            'org.codehaus.groovy.grails.web.mapping', // URL mapping
            'org.codehaus.groovy.grails.commons', // core / classloading
            'org.codehaus.groovy.grails.plugins', // plugins
            'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
            'org.springframework',
            'org.hibernate',
            'net.sf.ehcache.hibernate',
            'org.codehaus.groovy.grails.plugins.orm.auditable',
            'org.mortbay.log', 'org.springframework.webflow',
            'grails.app',
            'org.apache',
            'org',
            'com',
            'au',
            'grails.app',
            'net',
            'grails.util.GrailsUtil'
    warn    'org.mortbay.log',
            'grails.app'
    info    'grails.app'

    environments {
        development {
            // Override previous setting for 'grails.app'
            debug  'grails.app'
        }
    }
}