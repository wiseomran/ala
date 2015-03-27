# Introduction #

How to setup install a grails plugin in maven.ala.org.au so it can be used within other projects and dynamically downloaded for an initial build.

# Details #

1. Configure plugin `BuildConfig.groovy` by adding the `release` plugin:

```
grails.project.dependency.resolution = {
    ...
    plugins {
        build(":tomcat:$grailsVersion",
              ":release:2.0.3") {
            export = false
        }
    }
}
```

2. Edit local Grails settings file in `~/.grails/settings.groovy`:

```
grails.project.repos.default = "ala-repository"
grails.project.repos.'ala-repository'.url = "scp://maven.ala.org.au:/data/maven"
grails.project.repos.'ala-repository'.username = "maven"
grails.project.repos.'ala-repository'.password = "askSomeoneForThisPassword"
```

3. Optionally compile project to get release plugin included:

```
grails prod compile
```

4. Deploy plugin to ALA maven server:

```
grails maven-deploy --repository='ala-repository'
```

5. Check that it worked by browsing to repository:

http://maven.ala.org.au/repository/org/grails/plugins/

6. For projects wishing to use the plugin, include the following in `BuildConfig.groovy`

```
mavenRepo "http://maven.ala.org.au/repository/"
```

  * Add a line like this to `application.properties`:

```
plugins.ala-charts=0.2.3
```

  * or add the following to `BuildConfig.groovy`:

```
runtime ":ala-charts:0.2.3"
```