<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add new Machine</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="machine.vm_code"
                  :rules="rules.vm_code"
                  label="Machine Code"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="machine.location"
                  :rules="rules.location"
                  label="Location Link"
                  required
                ></v-text-field>
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
      machine: {
        vm_code: "",
        location: "",
      },
      rules: {
        vm_code: [(v) => !!v || "Machine code is required"],
        location: [(v) => !!v || "Location link is required"],
      },
    };
  },
  methods: {
    open(mode, data) {
      this.dialog = true;
      this.mode = mode;
      if (data) {
        this.machine = { ...data };
      }
    },
    close() {
      this.dialog = false;
      this.clearData();
    },
    clearData() {
      this.machine = {
        vm_code: "",
        lat: "",
        lng: "",
      };
      this.$refs.form.reset();
    },
    save() {
      if (this.$refs.form.validate()) {
        this.$emit(this.mode, this.machine);
      }
    },
  },
};
</script>
