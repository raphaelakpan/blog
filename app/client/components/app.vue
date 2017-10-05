<template>
  <div id="app">
    <p>{{ message }}</p>
    <input type="text" placeholder="Type here..." v-model="message"/>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
