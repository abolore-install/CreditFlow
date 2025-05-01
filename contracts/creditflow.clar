;; Title: CreditFlow - Decentralized Credit and Lending Protocol
;;
;; Summary:
;; A Bitcoin-compliant lending protocol built on Stacks that creates a decentralized 
;; credit scoring system enabling collateralized loans with dynamic interest rates.
;;
;; Description:
;; CreditFlow implements a credit-based lending system where users build reputation
;; through successful loan repayments. The protocol rewards responsible borrowers
;; with better interest rates and lower collateral requirements over time.
;;
;; Key features:
;; - Dynamic credit scoring (50-100)
;; - Collateral requirements adjusted by credit score
;; - Interest rates determined by borrower reputation
;; - Automatic score adjustments based on repayment behavior
;; - Compatible with Bitcoin finality and Stacks 2.0 architecture

;; Constants

(define-constant CONTRACT-OWNER tx-sender)

;; Error Codes
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))
(define-constant ERR-INVALID-AMOUNT (err u3))
(define-constant ERR-LOAN-NOT-FOUND (err u4))
(define-constant ERR-LOAN-DEFAULTED (err u5))
(define-constant ERR-INSUFFICIENT-SCORE (err u6))
(define-constant ERR-ACTIVE-LOAN (err u7))
(define-constant ERR-NOT-DUE (err u8))
(define-constant ERR-INVALID-DURATION (err u9))
(define-constant ERR-INVALID-LOAN-ID (err u10))

;; Credit Score Parameters
(define-constant MIN-SCORE u50)
(define-constant MAX-SCORE u100)
(define-constant MIN-LOAN-SCORE u70)

;; Data Maps

(define-map UserScores
    { user: principal }
    {
        score: uint,
        total-borrowed: uint,
        total-repaid: uint,
        loans-taken: uint,
        loans-repaid: uint,
        last-update: uint
    }
)

(define-map Loans
    { loan-id: uint }
    {
        borrower: principal,
        amount: uint,
        collateral: uint,
        due-height: uint,
        interest-rate: uint,
        is-active: bool,
        is-defaulted: bool,
        repaid-amount: uint
    }
)

(define-map UserLoans
    { user: principal }
    { active-loans: (list 20 uint) }
)

;; Variables

(define-data-var next-loan-id uint u0)
(define-data-var total-stx-locked uint u0)

;; Public Functions

;; Initialize a new user's credit score
(define-public (initialize-score)
    (let ((sender tx-sender))
        (asserts! (is-none (map-get? UserScores { user: sender })) ERR-UNAUTHORIZED)
        (ok (map-set UserScores
            { user: sender }
            {
                score: MIN-SCORE,
                total-borrowed: u0,
                total-repaid: u0,
                loans-taken: u0,
                loans-repaid: u0,
                last-update: stacks-block-height
            })
        )
    )
)