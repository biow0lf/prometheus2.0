#! /bin/sh

rubocop --only Lint/StringConversionInInterpolation
rubocop --only Lint/DeprecatedClassMethods
rubocop --only Style/ColonMethodCall
rubocop --only Style/LeadingCommentSpace
rubocop --only Style/SingleSpaceBeforeFirstArg
