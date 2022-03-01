<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add new</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-row>
              <v-col cols="12">
                <v-select
                  v-model="stock.vm_code"
                  :items="itemMachines"
                  item-text="vm_code"
                  item-value="vm_code"
                  :rules="[(v) => !!v || 'Machine is required']"
                  label="Select Machine"
                  required
                ></v-select>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="stock.channel"
                  :counter="13"
                  :rules="[(v) => !!v || 'Channel is required']"
                  label="Channel"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-select
                  v-model="stock.prod_id"
                  :items="itemProducts"
                  item-text="prodName"
                  item-value="id"
                  :rules="[(v) => !!v || 'Product is required']"
                  label="Select Product"
                  required
                ></v-select>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="stock.maxqty"
                  label="Max QTY"
                  type="number"
                  :rules="[(v) => !!v || 'Max is required']"
                  required
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="stock.restqty"
                  label="Rest QTY"
                  type="number"
                  :rules="[(v) => !!v || 'Rest is required']"
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
      stock: {
        vm_code: "",
        channel: "",
        prod_id: "",
        maxqty: "",
        restqty: "",
      },
      itemProducts: [],
      itemMachines: [],
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      this.itemProducts = await this.$axios.$get("/api/products");
      this.itemMachines = await this.$axios.$get("/api/machine");
    },
    open(mode, data) {
      this.dialog = true;
      this.mode = mode;
      if (data) {
        this.stock = { ...data };
      }
    },
    close() {
      this.dialog = false;
      this.clearData();
    },
    clearData() {
      this.stock = {
        vm_code: "",
        channel: "",
        prod_id: "",
        maxqty: "",
        restqty: "",
      };
      this.$refs.form.reset();
    },
    save() {
      if (this.$refs.form.validate()) {
        this.$emit(this.mode, this.stock);
      }
    },
  },
};
</script>
