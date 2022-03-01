<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add new Product</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="product.prodName"
                  :rules="rules.prodName"
                  label="Product"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="product.eanCode"
                  :counter="13"
                  :rules="rules.eanCode"
                  label="EAN Code"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="product.price"
                  label="Price"
                  type="number"
                  :rules="rules.price"
                  required
                />
              </v-col>
            </v-row>
          </v-form>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn text @click="close"> CLOSE </v-btn>
        <v-btn color="blue darken-1" text @click="save"> SAVE </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      mode: "",
      valid: true,
      product: {
        prodName: "",
        eanCode: "",
        price: "",
      },
      rules: {
        prodName: [(v) => !!v || "Product is required"],
        eanCode: [
          (v) => !!v || "EAN Code is required",
          (v) => (v && v.length == 13) || "EAN Code must be 13 characters",
        ],
        price: [(v) => !!v || "Price is required"],
      },
    };
  },
  methods: {
    open(mode, data) {
      this.dialog = true;
      this.mode = mode;
      if (data) {
        this.product = { ...data };
      }
    },
    close() {
      this.dialog = false;
      this.clearData();
    },
    clearData() {
      this.product = {
        prodName: "",
        eanCode: "",
        price: "",
      };
      this.$refs.form.reset();
    },
    save() {
      if (this.$refs.form.validate()) {
        this.$emit(this.mode, this.product);
      }
    },
  },
};
</script>
