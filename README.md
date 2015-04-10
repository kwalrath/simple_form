Angular 2 samples that you probably shouldn't copy.

Both have issues.

**simple_form** doesn't validate its appellation field. (Empty or non-existent is OK; all lowercase is not.)

**forms** throws an error when you click Add Question, because BroadcastStream expects listen, not subscribe.
(My code doesn't call listen; it must be in Angular somewhere.)
