export const state = () => ({
    lessCounter: 0,
    lessStock: []
})

export const mutations = {
    getLessStock(state, text) {
        state.lessStock = text
        state.lessCounter = text.length
    }
}