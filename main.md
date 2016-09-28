riot.js
=======
github.com/BrestJS/2016-riot-js

introduction

aveu 😖

{outils web} ≡ {outils serveurs}

pouchdb
moment(-timezone)
superagent
socket.io-client

webpack
zappajs

riot.js
-------

HTML = DSL for the web

```
<my-tag>
  .               .
  .               .
  .               .
</my-tag>
```

```
<my-tag>
  <input/>
  .               .
  .               .
</my-tag>
```

```
<my-tag>
  <input/>
  <style></style>
  .               .
</my-tag>
```

```
<my-tag>
  <input/>
  <style></style>
  <script><​/script>
</my-tag>
```

```
<my-tag>
  <input
    name=bear
    onkeyup={update}
  />
  <span>{bear.value}</span>
</my-tag>
```

environment

```
<html><body>
  <my-tag></my-tag>
  <script
    src="my-tag.tag"
    type="riot/tag"
  ><​/script>
  <script src="riot+compiler.min.js"><​/script>
  <script>
    riot.mount('my-tag')
  <​/script>
</body></html>
```

Polymorphe, renders server-side

riot = require('riot')
tag = require('my-app.tag')
html = riot.render(tag,opts)

/environment

```
<my-tag>
  <input
    name=bear
    onkeyup={update}
  />
  <span>{bear.value}</span>
  .                             .
  .                             .
  .                             .
</my-tag>
```

```
<my-tag>
  <input
    name=bear
    onkeyup={update_tag}
  />
  <span>{bear.value}</span>
  this.update_tag = (function() {
    this.update()
  }).bind(this)
</my-tag>
```

```
<my-tag>
  <input
    name=bear
    onkeyup={update_tag}
  />
  <span>{bear.value}</span>
  this.update_tag =  =>         {
    this.update()
  }
</my-tag>
```

```
<my-tag>
  <input
    name=bear
    onkeyup={handler}
  />
  <span>{bear_value}</span>
  this.handler = => {
    this.bear_value = this.bear.value
  }
</my-tag>
```

```
<my-tag>
  <input
    name=bear
    onkeyup={handler}
  />
  <span>{bear_value}</span>
  this.handler = (ev) => {
    this.bear_value = ev.target.value
  }
</my-tag>
```

script type ⊇
{java|coffee|es6|babel|type|live}

Loops
-----

```
<ul>
  <li each={ value, index in items }>
    { value } at { index }
  <li each>
</ul>
```

```
<todo>
  <ul>
    <li each={ items } class={ completed: done }>
      <input type=checkbox checked={ done }> { title }
    </li>
  </ul>
  this.items = [
    { title: 'Loops', done: true },
    { title: 'Nesting' },
    { title: 'Mixins' }
  ]
</todo>
```

Nesting
-------
and parameters

```
<my-app>
  <my-tag
    bear="teddy"
  ></my-tag>
</my-app>
…
<my-tag>
  this.bear = opts.bear
</my-tag>
```

```
<my-tag>
  this.bear = opts.bear
</my-tag>
```

```
(function(opts) {
  this.bear = opts.bear
}).bind(tag_context)
```

```
<my-app>
  <my-tag
    onchange={new_bear}
  ></my-tag>
</my-app>
…
<my-tag>
  this.on 'some-event', => {
    opts.onchange()
  }
</my-tag>
```

```
<my-app>
  <my-tag
    bear={changing_bear}
  ></my-tag>
</my-app>
```

```
<my-tag>
  this.bear = opts.bear
  this.on('update', => {
    this.bear = opts.bear
  })
</my-tag>
```

Conditionals
------------

```
<my-app>
  <div if={is_available}>…</div>
  <div show={is_present}>…</div>
  <div hide={is_unavailable}>…</div>
</my-app>
```

Observables
-----------

```
var ev = riot.observable()
ev.on('event',function(data){})
.
.
.
ev.trigger('event',data)
```

Mixins
------
(and a bit of flux)

```
riot.mixin({
  init: function(){
    this.ev = ev
  }
})
```

```
<my-tag>
  <input name=bear onkeyup={handler} />
  <span>{bear_value}</span>
  /* on key up */
  this.handler = (e) => {
    this.ev.trigger('save-the-bear',e.target.value)
  }
  /* later */
  this.ev.on('save-the-bear:done', (value) => {
    this.bear_value = value;
    this.update()
  })
</my-tag>
```

```
// var request = require('superagent')
ev.on('save-the-bear', function(value){
  request
    .post('/save-the-bear')
    .send(value)
    .end(function(){
      ev.trigger('save-the-bear:done')
    })
})
```

```
// var socket = io()
ev.on('save-the-bear', function(value){
  socket.emit('save-the-bear', value, function(value){
    ev.trigger('save-the-bear:done')
  })
})
```

```
// var db = new PouchDB()
ev.on('save-the-bear', function(value){
  db
  .get('bear')
  .then( function(doc){
    doc.bear = value
    db.put(doc)
  }).then( function(){
    ev.trigger('save-the-bear:done')
  })
})
```

```
<my-spinner>
  <!-- FontAwesome spinner -->
  <i class="fa fa-spinner { fa-spin: spinning } "></i>
  this.ev.on('save-the-bear', => {
    this.spinning = true
    this.update()
  })
  this.ev.on('save-the-bear:done', => {
    this.spinning = false
    this.update()
  })
</my-spinner>
```

Webpack
=======

webpack(-dev-server)
tag-loader
[ babel-loader, coffee-loader?literate ]

```
# client.coffee.md
require './my-app.tag'
require './my-tag.tag'
domready = require 'domready'
riot = require 'riot'
domready ->
  riot.mount '*'
```

```
# .babelrc
{
  "presets": [
      [ "es2015", { "modules": false } ]
    ],
   "plugins": [
     "transform-regenerator"
   ]
}
```

❁ Questions? ❁

❦ Merci! ❧
==========
github.com/BrestJS/2016-riot-js
_shimaore_
