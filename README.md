# Decidim::AlternativeLanding - Additional Content Blocks For Decidim

[![[CI] Test](https://github.com/Platoniq/decidim-module-alternative_landing/actions/workflows/test.yml/badge.svg)](https://github.com/Platoniq/decidim-module-alternative_landing/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/Platoniq/decidim-module-alternative_landing/branch/main/graph/badge.svg?token=qUp5m7up6M)](https://codecov.io/gh/Platoniq/decidim-module-alternative_landing)
[![Maintainability](https://api.codeclimate.com/v1/badges/565a00f5d7d1ed9879e7/maintainability)](https://codeclimate.com/github/Platoniq/decidim-module-alternative_landing/maintainability)

This module provides alternative and additional content blocks for the Decidim Homepage and Process Groups homepages.

Content Blocks are Admin-managed blocks that can be freely disposed, currently in the Homepage and in a Process Group Homepage. Probably in the future there will be more places where to place it.

With this module your Decidim instance will have access to:

- A Calendar widget for the homepage with active events in it.
- Extra info
- Alternative "Hero" style blocks, with images and text positioned in several ways (horizontal/vertical stacks, tiled, etc)
- Highlighted consultations
- Latest blog posts (with the ability to choose which ones to show)
- Upcoming meetings

We welcome PR with additional content blocks that can expand similar functionalities.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-alternative_landing", git: "https://github.com/Platoniq/decidim-module-alternative_landing",
```

And then execute:

```bash
bundle
```

## Contributing

See [Decidim](https://github.com/Platoniq/decidim-module-alternative_landing).

### Developing

To start contributing to this project, first:

- Install the basic dependencies (such as Ruby and PostgreSQL)
- Clone this repository

Decidim's main repository also provides a Docker configuration file if you
prefer to use Docker instead of installing the dependencies locally on your
machine.

You can create the development app by running the following commands after
cloning this project:

```bash
$ bundle
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake development_app
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

Then to test how the module works in Decidim, start the development server:

```bash
$ cd development_app
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails s
```

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add the environment variables to the root directory of the project in a file
named `.rbenv-vars`. If these are defined for the environment, you can omit
defining these in the commands shown above.

#### Code Styling

Please follow the code styling defined by the different linters that ensure we
are all talking with the same language collaborating on the same project. This
project is set to follow the same rules that Decidim itself follows.

[Rubocop](https://rubocop.readthedocs.io/) linter is used for the Ruby language.

You can run the code styling checks by running the following commands from the
console:

```
$ bundle exec rubocop
```

To ease up following the style guide, you should install the plugin to your
favorite editor, such as:

- Atom - [linter-rubocop](https://atom.io/packages/linter-rubocop)
- Sublime Text - [Sublime RuboCop](https://github.com/pderichs/sublime_rubocop)
- Visual Studio Code - [Rubocop for Visual Studio Code](https://github.com/misogi/vscode-ruby-rubocop)

### Testing

To run the tests run the following in the gem development path:

```bash
$ bundle
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake test_app
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rspec
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add these environment variables to the root directory of the project in a
file named `.rbenv-vars`. In this case, you can omit defining these in the
commands shown above.

### Test code coverage

If you want to generate the code coverage report for the tests, you can use
the `SIMPLECOV=1` environment variable in the rspec command as follows:

```bash
$ SIMPLECOV=1 bundle exec rspec
```

This will generate a folder named `coverage` in the project root which contains
the code coverage report.

### Localization

If you would like to see this module in your own language, you can help with its
translation at Crowdin:

https://crowdin.com/project/decidim-alternative-landing

## License

See [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt).

## Credits

This module is being developed in the context of the OpenHeritage project which has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 776766

<div style="display: flex">
<img height=100 src="images/EU.png"/>
<img height=100 src="images/OH.png"/>
</div>
