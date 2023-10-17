<script setup>
import { ref, toRaw } from "vue";
let sliderValue = ref(localStorage.getItem('cooktimeslider') || 30);
</script>
<template>
  <div>
    <SearchstaxFacetsWidget :facetingType="'or'" :itemsPerPageDesktop="3" :itemsPerPageMobile="99">
      <template
        #desktopFacets="{
          facetsTemplateDataDesktop,
          isNotDeactivated,
          toggleFacetGroup
        }"
      >
        <div
          v-if="facetsTemplateDataDesktop?.hasResultsOrExternalPromotions"
          class="searchstax-facets-container-desktop"
        >
          <div
            v-for="facet in facetsTemplateDataDesktop.facets"
            :key="facet"
            class="searchstax-facet-container"
            :class="{ active: isNotDeactivated(facet.name) }"
          >
            <div v-if="facet.name === 'its_field_cooking_time'">
              <div class="searchstax-facet-title-container" @click="toggleFacetGroup(facet.name)">
                <div class="searchstax-facet-title">{{ facet.label }}</div>
              </div>
              <div class="searchstax-facet-values-container">
                <input
                  v-model="sliderValue"
                  type="range"
                  min="5"
                  max="60"
                  step="5"
                  class="slider"
                  @change="sliderChange($event, facet)"
                />
                {{ sliderValue }} m
              </div>
            </div>
          </div>
        </div>
      </template>
    </SearchstaxFacetsWidget>
  </div>
</template>

<script>
import { SearchstaxFacetsWidget } from '@searchstax-inc/searchstudio-ux-vue'
export default {
  components: {
    SearchstaxFacetsWidget
  },
  methods: {
    sliderChange(e, facet) {
      let vals = toRaw(facet.values);
      if (vals) {
        const url = new URL(window.location.href);
        vals.forEach((facetValue, key) => {
          let f = toRaw(facetValue);
          url.searchParams.delete(`searchstax[facets][${key}]`);
          if (parseInt(f.value) <= parseInt(e.target.value)) {
            url.searchParams.set(`searchstax[facets][${key}]`, 'or:its_field_cooking_time:' + facetValue.value);
          }
        });
        localStorage.setItem('cooktimeslider', parseInt(e.target.value));
        url.search = decodeURIComponent(url.search);
        history.pushState({}, "", url);
        this.$router.go(0);
      }
    }
  }
}
</script>

<style scoped></style>
