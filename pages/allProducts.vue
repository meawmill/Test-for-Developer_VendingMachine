<template>
  <v-card>
    <v-card-title>
      <v-btn depressed color="primary">
        + New
      </v-btn>
      <v-spacer />
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      />
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="products"
      :search="search"
    >
      <template #[`item.actions`]="{ item }">
        <v-icon
          small
          class="mr-2"
          @click="editItem(item)"
        >
          edit
        </v-icon>
        <v-icon
          small
          @click="deleteItem(item)"
        >
          mdi-delete
        </v-icon>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
export default {
  name: 'AllProducts',
  data () {
    return {
      search: '',
      headers: [
        { text: 'ชื่อขนม', value: 'name' },
        { text: 'ชื่อร้าน', value: 'store' },
        { text: 'ราคา (บาท)', value: 'price' },
        { text: 'Actions', value: 'action', sortable: false }
      ],
      products: [
        {
          name: 'โมจิรสองุ่น',
          store: 'โมจิเฮ้',
          price: 100
        }
      ]
    }
  },
  methods: {
    editItem (item) {},
    deleteItem (item) {}
  }
}
</script>
