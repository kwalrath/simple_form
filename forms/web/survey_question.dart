// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of forms_example;

// SurveyQuestion renders an individual question. It can used as follows:
//
//     <survey-question [question]="question" [index]="i" (delete)="onDelete()"></survey-question>
//
// SurveyQuestion uses EventEmitter to fire the delete action.
// This component is self-contained and can be tested in isolation.
@Component(
    selector: 'survey-question',
    bind: const {"question": "question", "index": "index"})
@Template(inline: '''
   <h2>Question #{{index}}</h2>

   <button (click)="deleteQuestion()">Delete</button>

   <div [control-group]="question">
     <div>
       <label>Type:</label> <br/>
       <select control="type">
         <option value=""></option>
         <option value="text">Text</option>
         <option value="checkbox">Checkbox</option>
         <option value="textarea">Textarea</option>
       </select>
       <div *if="! question.controls['type'].valid && question.controls['type'].dirty">
         Type is required
       </div>
     </div>

     <div>
       <label>Question:</label> <br/>
       <input type="text" control="questionText">
       <div *if="! question.controls['questionText'].valid && question.controls['questionText'].dirty">
         Question is required
       </div>
     </div>

     <div *if="question.contains('responseLength')">
       <label>Response Length:</label> <br/>
       <input type="number" control="responseLength">
       <div *if="! question.controls['responseLength'].valid && question.controls['responseLength'].dirty">
         Length is required
       </div>
     </div>
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
class SurveyQuestion {
  ControlGroup question;
  num index;
  Function onDelete;

  SurveyQuestion(@EventEmitter("delete") Function this.onDelete);

  deleteQuestion() {
    // Invoking an injected event emitter will fire an event,
    // which in this case will result in calling `deleteQuestion(i)`
    onDelete();
  }
}
