<template>
  <v-card>
    <v-card-title>
      <v-btn depressed color="primary" @click="addItem"> + New </v-btn>
      <v-spacer />
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      />
    </v-card-title>

    <v-data-table :headers="headers" :items="products" :search="search">
      <template v-slot:item.action="{ item }">
        <v-icon small class="mr-2" @click="editItem(item)"> mdi-pencil </v-icon>
        <v-icon small @click="deleteItem(item)"> mdi-delete </v-icon>
      </template>
    </v-data-table>

    <ProductForm ref="ProductForm" @add="submitAdd" @edit="submitEdit" />

    <v-snackbar v-model="snackbar.show" :color="snackbar.type">
      {{ snackbar.text }}
      <v-btn color="blue" text @click="snackbar.show = false"> Close </v-btn>
    </v-snackbar>

    <v-dialog v-model="confirm" max-width="350">
      <v-card>
        <v-card-title class="headline"> Confirm Delete? </v-card-title>

        <v-card-text>
          Once confirmed, you will not be able to restore this data.
        </v-card-text>

        <v-card-actions>
          <v-spacer />

          <v-btn text @click="confirm = false"> Cancel </v-btn>

          <v-btn color="green darken-1" text @click="submitDelete">
            Confirm
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
import ProductForm from "~/components/forms/Product";

export default {
  components: { ProductForm },
  data() {
    return {
      search: "",
      snackbar: {
        show: false,
        text: "",
        type: "",
      },
      currentPK: null,
      confirm: false,
      headers: [
        { text: "EAN Code", value: "eanCode" },
        { text: "Product", value: "prodName" },
        { text: "Price", value: "price" },
        { text: "Actions", value: "action", sortable: false },
      ],
      products: [],
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      this.products = await this.$axios.$get("/api/products");
    },
    addItem() {
      this.$refs.ProductForm.open("add");
    },
    editItem(item) {
      this.currentPK = item.id;
      this.$refs.ProductForm.open("edit", item);
    },
    deleteItem(item) {
      this.currentPK = item.id;
      this.confirm = true;
    },
    async submitAdd(data) {
      try {
        const result = await this.$axios.$post("/api/products", data);
        if (result) {
          this.snackbar = {
            show: true,
            text: "Success",
            type: "success",
          };
          this.$refs.ProductForm.close();
          this.fetchData();
        }
      } catch (e) {
        this.snackbar = {
          show: true,
          text: "Fail",
          type: "error",
        };
      }
    },
    async submitEdit(data) {
      try {
        const result = await this.$axios.$put(
          `/api/products/${this.currentPK}`,
          data
        );
        if (result) {
          this.snackbar = {
            show: true,
            text: "Success",
            type: "success",
          };
          this.$refs.ProductForm.close();
          this.fetchData();
        }
      } catch (e) {
        this.snackbar = {
          show: true,
          text: "Fail",
          type: "error",
        };
      }
    },
    async submitDelete() {
      this.confirm = false;
      try {
        await this.$axios.$delete(`/api/products/${this.currentPK}`);
        this.snackbar = {
          show: true,
          text: "Success",
          type: "success",
        };
        this.fetchData();
      } catch (e) {
        this.snackbar = {
          show: true,
          text: "Fail",
          type: "error",
        };
      }
    },
  },
};
</script>
