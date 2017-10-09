# Fastlane

Utilise Fastlane pour déployer de nouvelle version de pod.

# Bundler

Bunlder est un gestionaire de dépendence pour Ruby. Il utilise le fichier Gemfile pour identifier ses dépendences et Gemfile.lock pour identifier les gem et leur version.

``` code:bash
bundle install # the content of the Gemfile.lock
bundle update # according to specification of the Gemfile
```

# Fastlane Lanes

## release
Run to validate and push a new version to cocoapods

```
bundle exec fastlane release --verbose
```

## pre_release_validation
Run to validated the pod.
Options no_git_check: to be able to validate the pod on a different branch than master.

```
bundle exec fastlane pre_release_validation no_git_check:true --verbose
```
