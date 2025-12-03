<template>
  <section class="VPSidebarItem" style="margin-top: 20px">
    <label for="syntax" style="display: inline-block; margin-right: 10px"
      >Syntax:</label
    >
    <div class="options" style="display: inline-block">
      <button
        @click="selectOption('reasonml')"
        :class="{ selected: selectedOption === 'reasonml' }"
        style="margin-right: 10px"
      >
        Reason
      </button>
      <button
        @click="selectOption('ocaml')"
        :class="{ selected: selectedOption === 'ocaml' }"
      >
        OCaml
      </button>
    </div>
  </section>
</template>

<script>
const CLASS_PREFIX = "syntax__";
export default {
  data() {
    return {
      selectedOption: null,
    };
  },
  mounted() {
    // Read the last selected value from local storage
    const lastSelectedOption = localStorage.getItem("syntax");
    if (lastSelectedOption) {
      this.selectedOption = lastSelectedOption;
      this.selectOption(lastSelectedOption);
    } else {
      // Default to selecting OCaml if no value found in local storage
      this.selectOption("ocaml");
    }
  },
  methods: {
    selectOption(option) {
      document.body.classList.remove(`${CLASS_PREFIX}${this.selectedOption}`);
      document.body.classList.add(`${CLASS_PREFIX}${option}`);

      this.selectedOption = option;
      // Store the selected option in local storage
      localStorage.setItem("syntax", option);
    },
  },
};
</script>

<style scoped>
.selected {
  text-decoration: underline;
}
</style>
