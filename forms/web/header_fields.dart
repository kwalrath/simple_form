// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of forms_example;

// HeaderFields renders the bound header control group. It can used as follows:
//
//   <survey-header [header]="header"></survey-header>
//
// This component is self-contained and can be tested in isolation.
@Component(selector: 'survey-header', bind: const {"header": "header"})
@Template(inline: '''
   <div [control-group]="header">
     <div>
       <label>Title:</label> <br/>
       <input type="text" control="title"/>
       <div *if="! header.controls['title'].valid && header.controls['title'].dirty">
         Title is required
       </div>
     </div>

     <div>
       <label>Description:</label> <br/>
       <textarea control="description"></textarea>
       <div *if="! header.controls['description'].valid && header.controls['description'].dirty">
         Description is required
       </div>
     </div>

     <div>
       <label>Publish Date:</label> <br/>
       <input type="date" control="date"/>
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
class HeaderFields {
  ControlGroup header;
}
