part of simple_form;

@Component(selector: 'form-app', services: const [FormBuilder])
@Template(inline: '''
    <h1>Make a Name for Yourself</h1>

    <div [control-group]="form">
     <div>
       <label>First name:</label> <br/>
       <input type="text" control="firstName"/>
       <div *if="! form.controls['firstName'].valid && form.controls['firstName'].dirty">
         First name is required
       </div>
     </div>

     <div>
       <label>Appellation:</label> <br/>
       <input type="text" control="appellation"/>
     </div>

      <button (click)="submitName()">Name me!</button>
    </div>
  ''', directives: const [
  const [
    //XXX: workaround for FormDirectives not being const.
    ControlGroupDirective,
    ControlDirective,
    CheckboxControlValueAccessor,
    DefaultValueAccessor
  ],
  If
])
class FormApp {
  String fullName;
  ControlGroup form;
  FormBuilder builder;

  FormApp(FormBuilder b) {
    builder = b;
    form = b.group(
        {"firstName": ["", Validators.required]}, // XXX: is the "" the default value?
        {"appellation": ["Fierce", Validators.required]}); // XXX: how to validate this optional field?
                                                           // XXX: nullValidator made the app hang.
  }

  submitName() {
    print('\n  Submitting name!');
        
    fullName = form.controls['firstName'].value;
    
//    String appellation = form.controls['appellation'].value;
//    if (appellation.length > 0) { // XXX: check into validation
//      fullName += ' the $appellation';
//    }
    
    print('  Submitting name: $fullName\n');
  }
}
