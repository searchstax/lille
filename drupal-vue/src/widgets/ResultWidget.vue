<template>
  <div>
    <SearchstaxResultWidget :afterLinkClick="afterLinkClick">
      <template #results="{ searchResults, resultClicked }">
        <div class="searchstax-search-results" v-if="searchResults && searchResults.length">
          <div
            class="searchstax-search-result"
            :key="searchResult.uniqueId"
            v-for="searchResult in searchResults"
          >
            <a
              v-if="searchResult.url"
              :href="searchResult.url"
              :data-searchstax-unique-result-id="searchResult.uniqueId"
              @click="resultClicked(searchResult, $event)"
              class="searchstax-result-item-link"
            ></a>
            <div
              v-if="searchResult.thumbnail != null"
              class="searchstax-search-result-image-container"
            >
              <img class="searchstax-result-image" v-bind:src="'http://localhost:8088' + searchResult.thumbnail" />
            </div>
            <div class="searchstax-search-result-content">

                <div class="searchstax-search-result-title-wrapper">

                    <div class="searchstax-search-result-title-container">
                      <h2 class="searchstax-search-result-title">{{ searchResult.title }}</h2>
                    </div>

                    
                    <div v-if="searchResult.ribbon" class="searchstax-search-result-ribbon">
                      <span class="pill">{{ searchResult.ribbon }}</span>
                      <div v-if="searchResult.promoted" class="searchstax-search-result-promoted"></div>
                    </div>
                </div>
                <p
                  v-if="searchResult.description"
                  class="searchstax-search-result-description searchstax-search-result-common"
                >
                  {{ searchResult.description }}
                </p>
                <div :key="unmappedField.key" v-for="unmappedField in searchResult.unmappedFields">
                    <div
                      v-if="unmappedField.key === 'its_field_preparation_time'"
                    >
                      <p class="searchstax-search-result-common"><b>Prep Time</b> - {{ unmappedField.value }} m</p>
                    </div>
                    <div
                      v-if="unmappedField.key === 'its_field_cooking_time'"
                    >
                      <p class="searchstax-search-result-common"><b>Cook Time</b> - {{ unmappedField.value }} m</p>
                    </div>
                </div>
            </div>

          </div>
        </div>
      </template>
    </SearchstaxResultWidget>
  </div>
</template>

<script>
import { SearchstaxResultWidget } from '@searchstax-inc/searchstudio-ux-vue'

export default {
  components: {
    SearchstaxResultWidget
  }
}
</script>

<style scoped></style>
