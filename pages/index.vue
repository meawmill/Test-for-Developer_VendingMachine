<template>
  <div>
    <v-row justify="center" align="center">
      <v-col
        v-for="machine in machinesStock"
        :key="machine.machine"
        cols="12"
        sm="8"
        md="6"
      >
        <v-card>
          <v-card-title class="headline">
            DRINKING VENDING MACHINE {{ machine.machine }}
          </v-card-title>
          <v-card-text v-for="(item, index) in machine.list" :key="item.id">
            <v-card class="mx-auto" max-width="344" outlined>
              <v-list-item three-line>
                <v-list-item-content>
                  <div class="text-overline mb-4">
                    Channel: {{ item.channel }} / Remaining: {{ item.restqty }}
                  </div>
                  <v-list-item-title class="text-h6 mb-1">
                    {{ item.products[0].prodName }}
                  </v-list-item-title>
                  <v-list-item-title class="text-h4 mb-1">
                    {{ item.products[0].price }} ฿
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-card-actions>
                <v-btn
                  :disabled="item.restqty == 0"
                  outlined
                  rounded
                  text
                  @click="buyThis(machine.list[index])"
                >
                  Buy this
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-dialog v-model="dialog" width="800" height="800">
      <v-stepper v-model="e1">
        <v-stepper-header>
          <v-stepper-step :complete="e1 > 1" step="1"> Payment </v-stepper-step>
          <v-divider></v-divider>
          <v-stepper-step :complete="e1 > 2" step="2">
            Wait Product
          </v-stepper-step>
        </v-stepper-header>

        <v-stepper-items>
          <v-stepper-content step="1">
            <v-card class="mx-auto text-center">
              <v-img src="img/eazycoin.gif" height="300"></v-img>
              <v-card-title class="text-h4 mb-5 text-center">
                Please pay {{ selectedProduct.price }} ฿
              </v-card-title>
              <v-card-subtitle>{{ selectedProduct.prodName }}</v-card-subtitle>
            </v-card>
            <v-card-actions class="text-center">
              <v-btn text @click="cancelPay()"> Cancel </v-btn>
              <v-btn
                color="primary"
                elevation="2"
                large
                rounded
                width="600"
                @click="payed()"
              >
                Payed
              </v-btn>
            </v-card-actions>
          </v-stepper-content>

          <v-stepper-content step="2">
            <v-card class="mx-auto text-center">
              <v-img src="img/loaddroping.gif" height="300"></v-img>
              <v-card-title class="text-h4 mb-5 text-center">
                Please Wait ...
              </v-card-title>
            </v-card>
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
    </v-dialog>
  </div>
</template>

<script>
export default {
  name: "IndexPage",
  data() {
    return {
      dialog: false,
      e1: 1,
      mode: "",
      valid: true,
      prodlist: [],
      machines: [],
      machinesStock: [],
      selectedProduct: {
        price: "0",
        prodName: "-",
      },
      selectedProductDetail: [],
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchLessStock() {
      this.lessstock = await this.$axios.$get("/api/buying/lessstock");
      this.$store.commit("getLessStock", this.lessStock);
    },
    async fetchData() {
      this.prodlist = await this.$axios.$get("/api/buying");
      this.machines = await this.$axios.$get("/api/machine");
      let machinelist = [];
      this.machines.forEach((e) => {
        const machine = this.prodlist.filter(
          (item) => item.vm_code == e.vm_code
        );
        const list = {
          machine: e.vm_code,
          list: machine,
        };
        machinelist.push(list);
      });
      this.machinesStock = machinelist;
    },
    buyThis(item) {
      this.dialog = true;
      this.selectedProduct = {
        price: item.products[0].price,
        prodName: item.products[0].prodName,
      };
      this.selectedProductDetail = item;
      console.log(item);
    },
    cancelPay() {
      this.dialog = false;
      this.e1 = 1;
    },
    async payed() {
      this.e1 = 2;
      const currentPK = this.selectedProductDetail.id;
      const restqty = this.selectedProductDetail.restqty;
      const remaining = restqty - 1;
      this.selectedProductDetail.restqty = remaining;
      try {
        const result = await this.$axios.$put(
          `/api/stock/${currentPK}`,
          this.selectedProductDetail
        );
        if (result) {
          this.snackbar = {
            show: true,
            text: "Success",
            type: "success",
          };
          this.fetchData();
          this.fetchLessStock();
          setTimeout(() => this.cancelPay(), 4000);
        }
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
