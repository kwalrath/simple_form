part of forms_example;

@Component(selector: 'survey-builder-app', services: const [FormBuilder])
@Template(inline: '''
    <h1>Create New Survey</h1>

    <div [control-group]="form">
      <survey-header [header]="form.controls['header']"></survey-header>

      <button (click)="addQuestion()">Add Question</button>
      <survey-question
          *for="var q of form.controls['questions'].controls; var i=index"
          [question]="q"
          [index]="i + 1"
          (delete)="deleteQuestion(i)">
      </survey-question>

      <button (click)="submitForm()">Submit</button>
    </div>
  ''', directives: const [
  const [
    //XXX: workaround for FormDirectives not being const.
    ControlGroupDirective,
    ControlDirective,
    CheckboxControlValueAccessor,
    DefaultValueAccessor
  ],
  For,
  HeaderFields,
  SurveyQuestion
])
class SurveyBuilder {
  ControlGroup form;
  FormBuilder builder;

  SurveyBuilder(FormBuilder b) {
    builder = b;
    form = b.group({
      "header": b.group({
        "title": ["", Validators.required],
        "description": ["", Validators.required],
        "date": ""
      }),
      "questions": b.array([])
    });
  }

  addQuestion() {
    var newQuestion = builder.group({
      "type": ["", Validators.required],
      "questionText": ["", Validators.required],
      "responseLength": [100, Validators.required]
    }, {
      // Optional controls can be dynamically added or removed from the form.
      // Here, the responseLength field is optional and not included by default.
      "optionals": {"responseLength": false}
    });

    // Every Control has an observable of value changes. You can subscribe to this observable
    // to update the form, update the application model, etc.
    // These observables can also be transformed and combined. This enables implementing
    // complex form interactions in a declarative fashion.
    //
    // We are disabling the responseLength control when the question type is checkbox.
    newQuestion.controls['type'].valueChanges.subscribe(
        (v) => // XXX: warning about type
            v == 'text' || v == 'textarea'
                ? newQuestion.include('responseLength')
                : newQuestion.exclude('responseLength'));

    form.controls['questions']
        .push(newQuestion); // XXX: how to turn off the warning about questions?
  }

  deleteQuestion(num index) {
    form.controls['questions']
        .removeAt(index); // XXX: how to turn off the warning about questions?
  }

  submitForm() {
    print('Submitting a form');
    print('value: ${form.value}, valid: ${form.valid}, errors: ${form.errors}');
  }
}
