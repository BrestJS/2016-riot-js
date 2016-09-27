<my-tag>
  <input name=bear onkeyup={handler} />
  <span>{bear_value}</span>
  <script>
    this.handler = (e) => {
      this.ev.trigger('save-the-bear',e.target.value)
    }
    this.ev.on('save-the-bear', (value) => {
      this.bear_value = value;
      this.update()
    })
  </script>
</my-tag>

