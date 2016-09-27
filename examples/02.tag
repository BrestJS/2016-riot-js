<my-tag>
  <input name=bear onkeyup={handler} />
  <span>{bear_value}</span>
  <script>
    this.handler = (e) =>
      this.bear_value = e.target.value
  </script>
</my-tag>
