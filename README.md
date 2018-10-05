# rubocop-junit_formatter
A JUnit Formatter for RuboCop. Usable with continuous integration services (eg. CircleCI) and IDEs.

## Usage
You *must* require the formatter file through the RuboCop CLI.

```bash
$ rubocop --require rubocop/formatter/junit_formatter --format RuboCop::Formatter::JUnitFormatter
```

To output the results to a file, use the `-o`/`--out` option:
```bash
$ rubocop --require rubocop/formatter/junit_formatter \
          --format RuboCop::Formatter::JUnitFormatter \
          --out /tmp/test-results/rubocop.xml
```

You can even have use multiple formatters (see [RuboCop manual](https://github.com/rubocop-hq/rubocop/blob/master/manual/formatters.md#formatters)). This is good for CIs where you want to stdout to be a more human readable formatter and output the JUnit XML to a file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-junit_formatter"
```

You'll probably only need to scope it to the `test` group.
