# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{railties}
  s.version = "3.0.0.beta"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.date = %q{2010-02-04}
  s.default_executable = %q{rails}
  s.description = %q{Controls boot-up, rake tasks and generators for the Rails framework.}
  s.email = %q{david@loudthinking.com}
  s.executables = ["rails"]
  s.files = ["CHANGELOG", "README", "bin/rails", "builtin/rails_info/rails/info.rb", "builtin/rails_info/rails/info_controller.rb", "builtin/rails_info/rails/info_helper.rb", "builtin/routes.rb", "guides/files/javascripts/code_highlighter.js", "guides/files/javascripts/guides.js", "guides/files/javascripts/highlighters.js", "guides/files/stylesheets/main.css", "guides/files/stylesheets/print.css", "guides/files/stylesheets/reset.css", "guides/files/stylesheets/style.css", "guides/files/stylesheets/syntax.css", "guides/images/belongs_to.png", "guides/images/book_icon.gif", "guides/images/bullet.gif", "guides/images/chapters_icon.gif", "guides/images/check_bullet.gif", "guides/images/credits_pic_blank.gif", "guides/images/csrf.png", "guides/images/customized_error_messages.png", "guides/images/error_messages.png", "guides/images/feature_tile.gif", "guides/images/footer_tile.gif", "guides/images/fxn.png", "guides/images/grey_bullet.gif", "guides/images/habtm.png", "guides/images/has_many.png", "guides/images/has_many_through.png", "guides/images/has_one.png", "guides/images/has_one_through.png", "guides/images/header_backdrop.png", "guides/images/header_tile.gif", "guides/images/i18n/demo_localized_pirate.png", "guides/images/i18n/demo_translated_en.png", "guides/images/i18n/demo_translated_pirate.png", "guides/images/i18n/demo_translation_missing.png", "guides/images/i18n/demo_untranslated.png", "guides/images/icons/callouts/1.png", "guides/images/icons/callouts/10.png", "guides/images/icons/callouts/11.png", "guides/images/icons/callouts/12.png", "guides/images/icons/callouts/13.png", "guides/images/icons/callouts/14.png", "guides/images/icons/callouts/15.png", "guides/images/icons/callouts/2.png", "guides/images/icons/callouts/3.png", "guides/images/icons/callouts/4.png", "guides/images/icons/callouts/5.png", "guides/images/icons/callouts/6.png", "guides/images/icons/callouts/7.png", "guides/images/icons/callouts/8.png", "guides/images/icons/callouts/9.png", "guides/images/icons/caution.png", "guides/images/icons/example.png", "guides/images/icons/home.png", "guides/images/icons/important.png", "guides/images/icons/next.png", "guides/images/icons/note.png", "guides/images/icons/prev.png", "guides/images/icons/README", "guides/images/icons/tip.png", "guides/images/icons/up.png", "guides/images/icons/warning.png", "guides/images/nav_arrow.gif", "guides/images/polymorphic.png", "guides/images/posts_index.png", "guides/images/rails_guides_logo.gif", "guides/images/rails_logo_remix.gif", "guides/images/rails_welcome.png", "guides/images/session_fixation.png", "guides/images/tab_grey.gif", "guides/images/tab_info.gif", "guides/images/tab_note.gif", "guides/images/tab_red.gif", "guides/images/tab_yellow.gif", "guides/images/tab_yellow.png", "guides/images/validation_error_messages.png", "guides/rails_guides/generator.rb", "guides/rails_guides/helpers.rb", "guides/rails_guides/indexer.rb", "guides/rails_guides/levenshtein.rb", "guides/rails_guides/textile_extensions.rb", "guides/rails_guides.rb", "guides/source/2_2_release_notes.textile", "guides/source/2_3_release_notes.textile", "guides/source/3_0_release_notes.textile", "guides/source/action_controller_overview.textile", "guides/source/action_mailer_basics.textile", "guides/source/action_view_overview.textile", "guides/source/active_record_basics.textile", "guides/source/active_record_querying.textile", "guides/source/active_support_core_extensions.textile", "guides/source/activerecord_validations_callbacks.textile", "guides/source/ajax_on_rails.textile", "guides/source/association_basics.textile", "guides/source/caching_with_rails.textile", "guides/source/command_line.textile", "guides/source/configuring.textile", "guides/source/contribute.textile", "guides/source/contributing_to_rails.textile", "guides/source/credits.textile.erb", "guides/source/debugging_rails_applications.textile", "guides/source/form_helpers.textile", "guides/source/generators.textile", "guides/source/getting_started.textile", "guides/source/i18n.textile", "guides/source/index.textile.erb", "guides/source/layout.html.erb", "guides/source/layouts_and_rendering.textile", "guides/source/migrations.textile", "guides/source/nested_model_forms.textile", "guides/source/performance_testing.textile", "guides/source/plugins.textile", "guides/source/rails_application_templates.textile", "guides/source/rails_on_rack.textile", "guides/source/routing.textile", "guides/source/security.textile", "guides/source/testing.textile", "lib/generators/erb/controller/controller_generator.rb", "lib/generators/erb/controller/templates/view.html.erb", "lib/generators/erb/mailer/mailer_generator.rb", "lib/generators/erb/mailer/templates/view.text.erb", "lib/generators/erb/scaffold/scaffold_generator.rb", "lib/generators/erb/scaffold/templates/_form.html.erb", "lib/generators/erb/scaffold/templates/edit.html.erb", "lib/generators/erb/scaffold/templates/index.html.erb", "lib/generators/erb/scaffold/templates/layout.html.erb", "lib/generators/erb/scaffold/templates/new.html.erb", "lib/generators/erb/scaffold/templates/show.html.erb", "lib/generators/erb.rb", "lib/generators/rails/app/app_generator.rb", "lib/generators/rails/app/templates/app/controllers/application_controller.rb", "lib/generators/rails/app/templates/app/helpers/application_helper.rb", "lib/generators/rails/app/templates/config/application.rb", "lib/generators/rails/app/templates/config/boot.rb", "lib/generators/rails/app/templates/config/databases/frontbase.yml", "lib/generators/rails/app/templates/config/databases/ibm_db.yml", "lib/generators/rails/app/templates/config/databases/mysql.yml", "lib/generators/rails/app/templates/config/databases/oracle.yml", "lib/generators/rails/app/templates/config/databases/postgresql.yml", "lib/generators/rails/app/templates/config/databases/sqlite3.yml", "lib/generators/rails/app/templates/config/environment.rb", "lib/generators/rails/app/templates/config/environments/development.rb.tt", "lib/generators/rails/app/templates/config/environments/production.rb.tt", "lib/generators/rails/app/templates/config/environments/test.rb.tt", "lib/generators/rails/app/templates/config/initializers/backtrace_silencers.rb", "lib/generators/rails/app/templates/config/initializers/cookie_verification_secret.rb.tt", "lib/generators/rails/app/templates/config/initializers/inflections.rb", "lib/generators/rails/app/templates/config/initializers/mime_types.rb", "lib/generators/rails/app/templates/config/initializers/session_store.rb.tt", "lib/generators/rails/app/templates/config/locales/en.yml", "lib/generators/rails/app/templates/config/routes.rb", "lib/generators/rails/app/templates/config.ru", "lib/generators/rails/app/templates/db/seeds.rb", "lib/generators/rails/app/templates/doc/README_FOR_APP", "lib/generators/rails/app/templates/Gemfile", "lib/generators/rails/app/templates/gitignore", "lib/generators/rails/app/templates/public/404.html", "lib/generators/rails/app/templates/public/422.html", "lib/generators/rails/app/templates/public/500.html", "lib/generators/rails/app/templates/public/favicon.ico", "lib/generators/rails/app/templates/public/images/rails.png", "lib/generators/rails/app/templates/public/index.html", "lib/generators/rails/app/templates/public/javascripts/application.js", "lib/generators/rails/app/templates/public/javascripts/controls.js", "lib/generators/rails/app/templates/public/javascripts/dragdrop.js", "lib/generators/rails/app/templates/public/javascripts/effects.js", "lib/generators/rails/app/templates/public/javascripts/prototype.js", "lib/generators/rails/app/templates/public/javascripts/rails.js", "lib/generators/rails/app/templates/public/robots.txt", "lib/generators/rails/app/templates/Rakefile", "lib/generators/rails/app/templates/README", "lib/generators/rails/app/templates/script/rails", "lib/generators/rails/app/templates/test/performance/browsing_test.rb", "lib/generators/rails/app/templates/test/test_helper.rb", "lib/generators/rails/app/USAGE", "lib/generators/rails/controller/controller_generator.rb", "lib/generators/rails/controller/templates/controller.rb", "lib/generators/rails/controller/USAGE", "lib/generators/rails/generator/generator_generator.rb", "lib/generators/rails/generator/templates/%file_name%_generator.rb.tt", "lib/generators/rails/generator/templates/USAGE.tt", "lib/generators/rails/generator/USAGE", "lib/generators/rails/helper/helper_generator.rb", "lib/generators/rails/helper/templates/helper.rb", "lib/generators/rails/helper/USAGE", "lib/generators/rails/integration_test/integration_test_generator.rb", "lib/generators/rails/integration_test/USAGE", "lib/generators/rails/mailer/mailer_generator.rb", "lib/generators/rails/mailer/templates/mailer.rb", "lib/generators/rails/mailer/USAGE", "lib/generators/rails/metal/metal_generator.rb", "lib/generators/rails/metal/templates/metal.rb", "lib/generators/rails/metal/USAGE", "lib/generators/rails/migration/migration_generator.rb", "lib/generators/rails/migration/USAGE", "lib/generators/rails/model/model_generator.rb", "lib/generators/rails/model/USAGE", "lib/generators/rails/model_subclass/model_subclass_generator.rb", "lib/generators/rails/observer/observer_generator.rb", "lib/generators/rails/observer/USAGE", "lib/generators/rails/performance_test/performance_test_generator.rb", "lib/generators/rails/performance_test/USAGE", "lib/generators/rails/plugin/plugin_generator.rb", "lib/generators/rails/plugin/templates/init.rb", "lib/generators/rails/plugin/templates/install.rb", "lib/generators/rails/plugin/templates/lib/%file_name%.rb.tt", "lib/generators/rails/plugin/templates/lib/tasks/%file_name%_tasks.rake.tt", "lib/generators/rails/plugin/templates/MIT-LICENSE.tt", "lib/generators/rails/plugin/templates/Rakefile.tt", "lib/generators/rails/plugin/templates/README.tt", "lib/generators/rails/plugin/templates/uninstall.rb", "lib/generators/rails/plugin/USAGE", "lib/generators/rails/resource/resource_generator.rb", "lib/generators/rails/resource/USAGE", "lib/generators/rails/scaffold/scaffold_generator.rb", "lib/generators/rails/scaffold/USAGE", "lib/generators/rails/scaffold_controller/scaffold_controller_generator.rb", "lib/generators/rails/scaffold_controller/templates/controller.rb", "lib/generators/rails/scaffold_controller/USAGE", "lib/generators/rails/session_migration/session_migration_generator.rb", "lib/generators/rails/session_migration/USAGE", "lib/generators/rails/stylesheets/stylesheets_generator.rb", "lib/generators/rails/stylesheets/templates/scaffold.css", "lib/generators/rails/stylesheets/USAGE", "lib/generators/test_unit/controller/controller_generator.rb", "lib/generators/test_unit/controller/templates/functional_test.rb", "lib/generators/test_unit/helper/helper_generator.rb", "lib/generators/test_unit/helper/templates/helper_test.rb", "lib/generators/test_unit/integration/integration_generator.rb", "lib/generators/test_unit/integration/templates/integration_test.rb", "lib/generators/test_unit/mailer/mailer_generator.rb", "lib/generators/test_unit/mailer/templates/fixture", "lib/generators/test_unit/mailer/templates/functional_test.rb", "lib/generators/test_unit/model/model_generator.rb", "lib/generators/test_unit/model/templates/fixtures.yml", "lib/generators/test_unit/model/templates/unit_test.rb", "lib/generators/test_unit/observer/observer_generator.rb", "lib/generators/test_unit/observer/templates/unit_test.rb", "lib/generators/test_unit/performance/performance_generator.rb", "lib/generators/test_unit/performance/templates/performance_test.rb", "lib/generators/test_unit/plugin/plugin_generator.rb", "lib/generators/test_unit/plugin/templates/%file_name%_test.rb.tt", "lib/generators/test_unit/plugin/templates/test_helper.rb", "lib/generators/test_unit/scaffold/scaffold_generator.rb", "lib/generators/test_unit/scaffold/templates/functional_test.rb", "lib/generators/test_unit.rb", "lib/rails/all.rb", "lib/rails/application/bootstrap.rb", "lib/rails/application/configurable.rb", "lib/rails/application/configuration.rb", "lib/rails/application/finisher.rb", "lib/rails/application/metal_loader.rb", "lib/rails/application/railties.rb", "lib/rails/application/routes_reloader.rb", "lib/rails/application.rb", "lib/rails/backtrace_cleaner.rb", "lib/rails/code_statistics.rb", "lib/rails/commands/application.rb", "lib/rails/commands/console.rb", "lib/rails/commands/dbconsole.rb", "lib/rails/commands/destroy.rb", "lib/rails/commands/generate.rb", "lib/rails/commands/performance/benchmarker.rb", "lib/rails/commands/performance/profiler.rb", "lib/rails/commands/plugin.rb", "lib/rails/commands/runner.rb", "lib/rails/commands/server.rb", "lib/rails/commands/update.rb", "lib/rails/commands.rb", "lib/rails/configuration.rb", "lib/rails/console/app.rb", "lib/rails/console/helpers.rb", "lib/rails/console/sandbox.rb", "lib/rails/deprecation.rb", "lib/rails/dispatcher.rb", "lib/rails/engine/configurable.rb", "lib/rails/engine/configuration.rb", "lib/rails/engine.rb", "lib/rails/generators/actions.rb", "lib/rails/generators/active_model.rb", "lib/rails/generators/base.rb", "lib/rails/generators/generated_attribute.rb", "lib/rails/generators/migration.rb", "lib/rails/generators/named_base.rb", "lib/rails/generators/resource_helpers.rb", "lib/rails/generators/test_case.rb", "lib/rails/generators.rb", "lib/rails/initializable.rb", "lib/rails/paths.rb", "lib/rails/performance_test_help.rb", "lib/rails/plugin.rb", "lib/rails/rack/debugger.rb", "lib/rails/rack/log_tailer.rb", "lib/rails/rack/logger.rb", "lib/rails/rack/static.rb", "lib/rails/rack.rb", "lib/rails/railtie/configurable.rb", "lib/rails/railtie/configuration.rb", "lib/rails/railtie.rb", "lib/rails/railties_path.rb", "lib/rails/ruby_version_check.rb", "lib/rails/rubyprof_ext.rb", "lib/rails/source_annotation_extractor.rb", "lib/rails/subscriber/test_helper.rb", "lib/rails/subscriber.rb", "lib/rails/tasks/annotations.rake", "lib/rails/tasks/documentation.rake", "lib/rails/tasks/framework.rake", "lib/rails/tasks/log.rake", "lib/rails/tasks/middleware.rake", "lib/rails/tasks/misc.rake", "lib/rails/tasks/routes.rake", "lib/rails/tasks/statistics.rake", "lib/rails/tasks/tmp.rake", "lib/rails/tasks.rb", "lib/rails/test_help.rb", "lib/rails/test_unit/railtie.rb", "lib/rails/test_unit/testing.rake", "lib/rails/version.rb", "lib/rails/webrick_server.rb", "lib/rails.rb", "lib/generators/rails/app/templates/app/models/.empty_directory", "lib/generators/rails/app/templates/app/views/layouts/.empty_directory", "lib/generators/rails/app/templates/public/stylesheets/.empty_directory", "lib/generators/rails/app/templates/test/fixtures/.empty_directory", "lib/generators/rails/app/templates/test/functional/.empty_directory", "lib/generators/rails/app/templates/test/integration/.empty_directory", "lib/generators/rails/app/templates/test/unit/.empty_directory", "lib/generators/rails/generator/templates/templates/.empty_directory"]
  s.homepage = %q{http://www.rubyonrails.org}
  s.rdoc_options = ["--exclude", "."]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rails}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Controls boot-up, rake tasks and generators for the Rails framework.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.8.3"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.13"])
      s.add_runtime_dependency(%q<activesupport>, ["= 3.0.0.beta"])
      s.add_runtime_dependency(%q<actionpack>, ["= 3.0.0.beta"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.3"])
      s.add_dependency(%q<thor>, ["~> 0.13"])
      s.add_dependency(%q<activesupport>, ["= 3.0.0.beta"])
      s.add_dependency(%q<actionpack>, ["= 3.0.0.beta"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.3"])
    s.add_dependency(%q<thor>, ["~> 0.13"])
    s.add_dependency(%q<activesupport>, ["= 3.0.0.beta"])
    s.add_dependency(%q<actionpack>, ["= 3.0.0.beta"])
  end
end
