;;; flycheck-jest-test.el --- Tests for `flycheck-jest' -*- lexical-binding: t -*-

(require 'flycheck-jest)
(require 'ert)
(require 'f)
(eval-when-compile (require 'subr-x))

(ert-deftest flycheck-jest--extract-line-test ()
  "Test `flycheck-jest--extract-line'."
  (let ((result (flycheck-jest--extract-line
                 " (Button.test.tsx:16:34) ")))
    (should (eq result 16))))

(ert-deftest flycheck-jest--extract-column-test ()
  "Test `flycheck-jest--extract-column'."
  (let ((result (flycheck-jest--extract-column
                 " (Button.test.tsx:16:34) ")))
    (should (eq result 34))))

(ert-deftest flycheck-jest--parse-json-test ()
  "Test `flycheck-jest--parse-json'."
  (let ((json
         (json-read-from-string
          "{\"numFailedTestSuites\":1,\"numFailedTests\":1,\"numPassedTestSuites\":0,\"numPassedTests\":1,\"numPendingTestSuites\":0,\"numPendingTests\":0,\"numRuntimeErrorTestSuites\":0,\"numTotalTestSuites\":1,\"numTotalTests\":2,\"snapshot\":{\"added\":0,\"didUpdate\":false,\"failure\":false,\"filesAdded\":0,\"filesRemoved\":0,\"filesUnmatched\":0,\"filesUpdated\":0,\"matched\":1,\"total\":1,\"unchecked\":0,\"unmatched\":0,\"updated\":0},\"startTime\":1518477045738,\"success\":false,\"testResults\":[{\"assertionResults\":[{\"ancestorTitles\":[],\"failureMessages\":[\"ReferenceError: renderer is not defined\\n    at Object.<anonymous> (/Users/james/Button.test.tsx:7:1)\\n    at Object.asyncFn (/Users/jamesjasmine_async.js:124:345)\\n    at resolve (/Users/james/queue_runner.js:46:12)\\n    at tryCallTwo (/Users/james/core.js:45:5)\\n    at doResolve (/Users/james/core.js:200:13)\\n    at new Promise (/Users/james/core.js:66:3)\\n    at mapper (/Users/james/queue_runner.js:34:499)\\n    at promise.then (/Users/james/queue_runner.js:74:39)\\n    at tryCallOne (/Users/james/core.js:37:12)\\n    at /Users/james/core.js:123:15\"],\"fullName\":\"renders correctly if total count is 0\",\"status\":\"failed\",\"title\":\"renders correctly if total count is 0\"},{\"ancestorTitles\":[],\"failureMessages\":[],\"fullName\":\"renders correctly if total count is greater than 0\",\"status\":\"passed\",\"title\":\"renders correctly if total count is greater than 0\"}],\"endTime\":1518477047136,\"message\":\"  ● renders correctly if total count is 0\\n\\n    ReferenceError: renderer is not defined\\n      \\n      at Object.<anonymous> (Button.test.tsx:7:1)\\n      at tryCallTwo (node_modules/promise/lib/core.js:45:5)\\n      at doResolve (node_modules/promise/lib/core.js:200:13)\\n      at new Promise (node_modules/promise/lib/core.js:66:3)\\n      at tryCallOne (node_modules/promise/lib/core.js:37:12)\\n      at node_modules/promise/lib/core.js:123:15\\n\",\"name\":\"/Users/james/Button.test.tsx\",\"startTime\":1518477046545,\"status\":\"failed\",\"summary\":\"\"}],\"wasInterrupted\":false}")))
    (let ((jest-results (flycheck-jest--parse-json json)))
      (should (eq (length jest-results) 1))
      (should (eq (plist-get (car jest-results) :line) 7))
      (should (eq (plist-get (car jest-results) :column) 1))
      (should (string-equal
               (plist-get (car jest-results) :filename)
               "/Users/james/Button.test.tsx")))))

;;; flycheck-jest-test.el ends here
