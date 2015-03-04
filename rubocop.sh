#! /bin/sh

# TODO:
rubocop --only Lint/ElseLayout

rubocop --only Lint/StringConversionInInterpolation
rubocop --only Lint/DeprecatedClassMethods
rubocop --only Style/ColonMethodCall
rubocop --only Style/LeadingCommentSpace
rubocop --only Style/SingleSpaceBeforeFirstArg
rubocop --only Style/WhenThen
rubocop --only Style/HashSyntax
# rubocop --only Metrics/LineLength
