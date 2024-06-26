#' Confirms conectivity to LLM interface
#' @inheritParams ch_submit
#' @returns It returns console massages with the status of the test.
#' @export
chattr_test <- function(defaults = NULL) {
  if (is.null(defaults)) defaults <- chattr_defaults()
  ch_test(defaults)
}

#' @rdname chattr_test
#' @export
ch_test <- function(defaults = NULL) {
  UseMethod("ch_test")
}

# ------------------------------ OpenAI ----------------------------------------
#' @export
ch_test.ch_openai_chat_completions <- function(defaults = NULL) {
  if (ch_debug_get()) {
    prompt <- "TEST"
    out <- "TEST"
  } else {
    prompt <- "Hi!"
    out <- capture.output(chattr(prompt))
  }

  if (is.null(out)) out <- ""

  cli_div(theme = cli_colors())
  cli_h3("Testing chattr")
  print_provider(defaults)

  if (nchar(out) > 0) {
    cli_alert_success("Connection with OpenAI cofirmed")
    cli_text("|--Prompt: {.val2 {prompt}}")
    cli_text("|--Response: {.val1 {out}}")
  } else {
    cli_alert_danger("Connection with OpenAI failed")
  }
}

# ----------------------------- LlamaGPT ---------------------------------------

#' @export
ch_test.ch_llamagpt <- function(defaults = NULL) {
  if (ch_debug_get()) {
    error <- ""
    x <- TRUE
  } else {
    ch_llamagpt_session(defaults = defaults, testing = TRUE)
    session <- ch_llamagpt_session()
    Sys.sleep(0.1)
    error <- session$read_error()
    x <- ch_llamagpt_stop()
  }

  cli_div(theme = cli_colors())
  cli_h3("Testing chattr")
  print_provider(defaults)

  if (error == "") {
    cli_alert_success("Model started sucessfully")
  } else {
    cli_text(error)
    cli_alert_danger("Errors loading model")
  }

  if (x) {
    cli_alert_success("Model session closed sucessfully")
  } else {
    cli_alert_danger("Errors closing model session")
  }
  invisible()
}

# ----------------------------- Copilot ----------------------------------------

#' @export
ch_test.ch_openai_github_copilot_chat <- function(defaults = NULL) {
  if (ch_debug_get()) {
    prompt <- "TEST"
    out <- "TEST"
  } else {
    prompt <- "Hi!"
    out <- capture.output(chattr(prompt))
  }

  if (is.null(out)) out <- ""

  cli_div(theme = cli_colors())
  cli_h3("Testing chattr")
  print_provider(defaults)

  if (nchar(out) > 0) {
    cli_alert_success("Connection with GitHub Copilot cofirmed")
    cli_text("|--Prompt: {.val2 {prompt}}")
    cli_text("|--Response: {.val1 {out}}")
  } else {
    cli_alert_danger("Connection with GitHub Copilot failed")
  }
}

#' @export
ch_submit.test_backend <- function(
    defaults,
    prompt = NULL,
    stream = NULL,
    prompt_build = TRUE,
    preview = FALSE,
    ...) {
  "test"
}
