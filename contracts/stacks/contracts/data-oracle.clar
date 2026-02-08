;; DataOracle - Consensus data feed
(define-constant ERR-NOT-VALIDATOR (err u100))
(define-constant ERR-ALREADY-SUBMITTED (err u101))

(define-map data-points
    { key: (buff 32) }
    { value: uint, submissions: uint }
)

(define-map submissions { key: (buff 32), validator: principal } { submitted: bool })
(define-map validators { validator: principal } { is-validator: bool })

(define-public (submit (key (buff 32)) (value uint))
    (begin
        (asserts! (default-to false (get is-validator (map-get? validators { validator: tx-sender }))) ERR-NOT-VALIDATOR)
        (asserts! (is-none (map-get? submissions { key: key, validator: tx-sender })) ERR-ALREADY-SUBMITTED)
        (map-set submissions { key: key, validator: tx-sender } { submitted: true })
        (let ((current (default-to { value: u0, submissions: u0 } (map-get? data-points { key: key }))))
            (map-set data-points { key: key } { value: value, submissions: (+ (get submissions current) u1) })
        )
        (ok true)
    )
)

(define-read-only (get-data (key (buff 32)))
    (map-get? data-points { key: key })
)
