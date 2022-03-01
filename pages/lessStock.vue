<template>
  <div>
    <v-card-title class="headline"> Less Stock List </v-card-title>
    <v-card v-for="item in lessStock" :key="item.id" class="mx-auto">
      <v-list subheader three-line>
        <v-list-item class="m-0">
          <v-subheader class="text-h6 m-0">
            Machine: {{ item.vm_code }}
          </v-subheader>
          <v-list-item-content>
            <v-list-item-title> Channel: {{ item.channel }} </v-list-item-title>
            <v-list-item-subtitle class="text-h8 m-0">
              {{ item.products[0].prodName }} =
              {{ item.restqty }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-divider></v-divider>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "DefaultLayout",
  data() {
    return {
      alertcount: 0,
      lessStock: [],
    };
  },
  mounted() {
    this.fetchLessStock();
  },
  methods: {
    async fetchLessStock() {
      const ls = await this.$axios.$get("/api/buying/lessstock");
      this.lessStock = ls;
      this.$root.$emit("updateCount", ls.length);
    },
  },
};
</script>
