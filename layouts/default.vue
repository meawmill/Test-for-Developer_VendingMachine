<template>
  <v-app dark>
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant="miniVariant"
      :clipped="clipped"
      fixed
      app
    >
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-btn icon @click.stop="miniVariant = !miniVariant">
        <v-icon>mdi-{{ `chevron-${miniVariant ? "right" : "left"}` }}</v-icon>
      </v-btn>
      <v-toolbar-title v-text="title" />
      <v-spacer></v-spacer>

      <v-tooltip left>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            v-bind="attrs"
            v-on="on"
            @click="$router.push('/lessStock')"
          >
            <v-badge
              :content="alertcount"
              :value="alertcount"
              color="red"
              overlap
            >
              <v-icon>mdi-bell</v-icon>
            </v-badge>
          </v-btn>
        </template>
        <span>Have alert less stock!</span>
      </v-tooltip>
    </v-app-bar>
    <v-main>
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
    <v-footer app>
      <strong>Developed by: Pornkanok Yawanopas</strong>
      &copy; {{ new Date().getFullYear() }}
    </v-footer>
  </v-app>
</template>

<script>
export default {
  name: "DefaultLayout",
  data() {
    return {
      alertcount: 0,
      clipped: true,
      drawer: false,
      fixed: true,
      miniVariant: false,
      items: [
        {
          icon: "mdi-apps",
          title: "Welcome",
          to: "/",
        },
        {
          icon: "mdi-chart-bubble",
          title: "Products",
          to: "/allproducts",
        },
        {
          icon: "mdi-microwave",
          title: "Vending Machines",
          to: "/vendingmachines",
        },
        {
          icon: "mdi-inbox-arrow-down",
          title: "Machines Stock",
          to: "/machineStock",
        },
        {
          icon: "mdi-alert-box",
          title: "Less Stock",
          to: "/lessStock",
        },
      ],
      title: "Drinking Vending Machine",
    };
  },
  created() {
    const me = this;
    this.$root.$on("updateCount", function () {
      me.fetchLessStock();
    });
  },
  methods: {
    async fetchLessStock() {
      const ls = await this.$axios.$get("/api/buying/lessstock");
      this.alertcount = ls.length;
    },
  },
};
</script>
