# Common Workflow Language Schema #

This library provides a command-line tool that is use for building the CWL
schema. Note that the version of the schema that is being build is availabe in
`schema/cwl.jsonnet` as a "private variable" `version:: "xxx"`.

## Prerequisites ##

1. Ruby 2.0.0+. See [rbenv](http://rbenv.org/) for installing Ruby.
2. [Bundler](http://bundler.io/). Run `gem install bundler` to install.
3. [jsonnet](http://google.github.io/jsonnet/doc/index.html) v0.8.5. If using
   OS X, you can install this with `brew install jsonnet`.

## Building the schema ##

1. Clone this repository.
2. Run `bundle install` to install dependencies.
3. Run `bundle exec rake build` to build the schema which gets writte to
   `dist/cwl.avpr`.

If you're having trouble with Ruby, you can manually run Jsonnet with:

```
jsonnet --var DOC=false schema/cwl.jsonnet > dist/cwl.avpr
```

We use Ruby to validate the document as a proper Avro protocol and prettify
it prior to writing to to `cwl.avpr`.
