<template>
  <div class="">
    <input type="text" placeholder="Enter Tag" v-model="currentTag" @keypress.enter="saveTag" />
    <!-- Suggest tags -->
    <ul v-show="suggestions.length > 0" class="suggestTags">
      <li v-for="(suggestion, index) in suggestions" :key="index" @click="selectSuggestion(index)"> {{suggestion}} </li>
    </ul>

    <span class="chip" v-for="(tag, index) in postTags" :key="index" style="margin-top: 5px">
      {{ tag }}
      <span class="close-tag" @click="removeTag(index)">X</span>
    </span>

    <input type="hidden" name="post[tag_list]" :value="postTags" />
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    props: ['id'],
    data() {
      return {
        currentTag: '',
        tags: [],
        suggestions: [],
        postTags: []
      }
    },
    methods: {
      saveTag(e, index) {
        e.preventDefault();

        this.postTags.push(this.toTitleCase(this.currentTag))
        this.currentTag = ''

      },

      removeTag(index) {
        this.postTags.splice(index, 1);
      },

      selectSuggestion(index) {
        this.currentTag = this.suggestions[index]
        this.suggestions = []
        this.postTags.push(this.currentTag)
        this.currentTag = ''
      },

      toTitleCase(word) {
        return word[0].toUpperCase() + word.slice(1)
      }
    },

    created() {
      axios.get('/tags').then(response => {
        this.tags = response.data

        if (this.id) {
           axios.get(`/posts/${this.id}/tags`).then(response => {
            this.postTags = response.data
           })
        }
      }).catch(error => {
        console.log(error)
      })
    },

    watch: {
      currentTag(value) {
        if (value == "") {
          this.suggestions = [];
          return;
        }

        this.suggestions = this.tags.filter((obj) => {
          return obj.toLowerCase().indexOf(value.toLowerCase()) >= 0
        })
      }
    }
  }
</script>
