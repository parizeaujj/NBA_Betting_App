/*
 * Copyright 2018 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Automatically generated nanopb header */
/* Generated by nanopb-0.3.9.7 */

#ifndef PB_GOOGLE_FIRESTORE_V1_FIRESTORE_NANOPB_H_INCLUDED
#define PB_GOOGLE_FIRESTORE_V1_FIRESTORE_NANOPB_H_INCLUDED
#include <pb.h>

#include "google/api/annotations.nanopb.h"

#include "google/firestore/v1/common.nanopb.h"

#include "google/firestore/v1/document.nanopb.h"

#include "google/firestore/v1/query.nanopb.h"

#include "google/firestore/v1/write.nanopb.h"

#include "google/protobuf/empty.nanopb.h"

#include "google/protobuf/timestamp.nanopb.h"

#include "google/rpc/status.nanopb.h"

#include <string>

namespace firebase {
namespace firestore {

/* @@protoc_insertion_point(includes) */
#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif


/* Enum definitions */
typedef enum _google_firestore_v1_TargetChange_TargetChangeType {
    google_firestore_v1_TargetChange_TargetChangeType_NO_CHANGE = 0,
    google_firestore_v1_TargetChange_TargetChangeType_ADD = 1,
    google_firestore_v1_TargetChange_TargetChangeType_REMOVE = 2,
    google_firestore_v1_TargetChange_TargetChangeType_CURRENT = 3,
    google_firestore_v1_TargetChange_TargetChangeType_RESET = 4
} google_firestore_v1_TargetChange_TargetChangeType;
#define _google_firestore_v1_TargetChange_TargetChangeType_MIN google_firestore_v1_TargetChange_TargetChangeType_NO_CHANGE
#define _google_firestore_v1_TargetChange_TargetChangeType_MAX google_firestore_v1_TargetChange_TargetChangeType_RESET
#define _google_firestore_v1_TargetChange_TargetChangeType_ARRAYSIZE ((google_firestore_v1_TargetChange_TargetChangeType)(google_firestore_v1_TargetChange_TargetChangeType_RESET+1))

/* Struct definitions */
typedef struct _google_firestore_v1_BeginTransactionResponse {
    pb_bytes_array_t *transaction;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_BeginTransactionResponse) */
} google_firestore_v1_BeginTransactionResponse;

typedef struct _google_firestore_v1_CommitRequest {
    pb_bytes_array_t *database;
    pb_size_t writes_count;
    struct _google_firestore_v1_Write *writes;
    pb_bytes_array_t *transaction;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_CommitRequest) */
} google_firestore_v1_CommitRequest;

typedef struct _google_firestore_v1_ListCollectionIdsResponse {
    pb_size_t collection_ids_count;
    pb_bytes_array_t **collection_ids;
    pb_bytes_array_t *next_page_token;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListCollectionIdsResponse) */
} google_firestore_v1_ListCollectionIdsResponse;

typedef struct _google_firestore_v1_ListDocumentsResponse {
    pb_size_t documents_count;
    struct _google_firestore_v1_Document *documents;
    pb_bytes_array_t *next_page_token;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListDocumentsResponse) */
} google_firestore_v1_ListDocumentsResponse;

typedef struct _google_firestore_v1_ListenRequest_LabelsEntry {
    pb_bytes_array_t *key;
    pb_bytes_array_t *value;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListenRequest_LabelsEntry) */
} google_firestore_v1_ListenRequest_LabelsEntry;

typedef struct _google_firestore_v1_RollbackRequest {
    pb_bytes_array_t *database;
    pb_bytes_array_t *transaction;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_RollbackRequest) */
} google_firestore_v1_RollbackRequest;

typedef struct _google_firestore_v1_Target_DocumentsTarget {
    pb_size_t documents_count;
    pb_bytes_array_t **documents;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_Target_DocumentsTarget) */
} google_firestore_v1_Target_DocumentsTarget;

typedef struct _google_firestore_v1_WriteRequest {
    pb_bytes_array_t *database;
    pb_bytes_array_t *stream_id;
    pb_size_t writes_count;
    struct _google_firestore_v1_Write *writes;
    pb_bytes_array_t *stream_token;
    pb_size_t labels_count;
    struct _google_firestore_v1_WriteRequest_LabelsEntry *labels;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_WriteRequest) */
} google_firestore_v1_WriteRequest;

typedef struct _google_firestore_v1_WriteRequest_LabelsEntry {
    pb_bytes_array_t *key;
    pb_bytes_array_t *value;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_WriteRequest_LabelsEntry) */
} google_firestore_v1_WriteRequest_LabelsEntry;

typedef struct _google_firestore_v1_BatchGetDocumentsRequest {
    pb_bytes_array_t *database;
    pb_size_t documents_count;
    pb_bytes_array_t **documents;
    google_firestore_v1_DocumentMask mask;
    pb_size_t which_consistency_selector;
    union {
        pb_bytes_array_t *transaction;
        google_firestore_v1_TransactionOptions new_transaction;
        google_protobuf_Timestamp read_time;
    };

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_BatchGetDocumentsRequest) */
} google_firestore_v1_BatchGetDocumentsRequest;

typedef struct _google_firestore_v1_BatchGetDocumentsResponse {
    pb_size_t which_result;
    union {
        google_firestore_v1_Document found;
        pb_bytes_array_t *missing;
    };
    pb_bytes_array_t *transaction;
    google_protobuf_Timestamp read_time;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_BatchGetDocumentsResponse) */
} google_firestore_v1_BatchGetDocumentsResponse;

typedef struct _google_firestore_v1_BeginTransactionRequest {
    pb_bytes_array_t *database;
    google_firestore_v1_TransactionOptions options;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_BeginTransactionRequest) */
} google_firestore_v1_BeginTransactionRequest;

typedef struct _google_firestore_v1_CommitResponse {
    pb_size_t write_results_count;
    struct _google_firestore_v1_WriteResult *write_results;
    google_protobuf_Timestamp commit_time;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_CommitResponse) */
} google_firestore_v1_CommitResponse;

typedef struct _google_firestore_v1_CreateDocumentRequest {
    pb_bytes_array_t *parent;
    pb_bytes_array_t *collection_id;
    pb_bytes_array_t *document_id;
    google_firestore_v1_Document document;
    google_firestore_v1_DocumentMask mask;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_CreateDocumentRequest) */
} google_firestore_v1_CreateDocumentRequest;

typedef struct _google_firestore_v1_DeleteDocumentRequest {
    pb_bytes_array_t *name;
    google_firestore_v1_Precondition current_document;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_DeleteDocumentRequest) */
} google_firestore_v1_DeleteDocumentRequest;

typedef struct _google_firestore_v1_GetDocumentRequest {
    pb_bytes_array_t *name;
    google_firestore_v1_DocumentMask mask;
    pb_size_t which_consistency_selector;
    union {
        pb_bytes_array_t *transaction;
        google_protobuf_Timestamp read_time;
    };

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_GetDocumentRequest) */
} google_firestore_v1_GetDocumentRequest;

typedef struct _google_firestore_v1_ListCollectionIdsRequest {
    pb_bytes_array_t *parent;
    int32_t page_size;
    pb_bytes_array_t *page_token;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListCollectionIdsRequest) */
} google_firestore_v1_ListCollectionIdsRequest;

typedef struct _google_firestore_v1_ListDocumentsRequest {
    pb_bytes_array_t *parent;
    pb_bytes_array_t *collection_id;
    int32_t page_size;
    pb_bytes_array_t *page_token;
    pb_bytes_array_t *order_by;
    google_firestore_v1_DocumentMask mask;
    pb_size_t which_consistency_selector;
    union {
        pb_bytes_array_t *transaction;
        google_protobuf_Timestamp read_time;
    };
    bool show_missing;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListDocumentsRequest) */
} google_firestore_v1_ListDocumentsRequest;

typedef struct _google_firestore_v1_RunQueryRequest {
    pb_bytes_array_t *parent;
    pb_size_t which_query_type;
    union {
        google_firestore_v1_StructuredQuery structured_query;
    } query_type;
    pb_size_t which_consistency_selector;
    union {
        pb_bytes_array_t *transaction;
        google_firestore_v1_TransactionOptions new_transaction;
        google_protobuf_Timestamp read_time;
    } consistency_selector;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_RunQueryRequest) */
} google_firestore_v1_RunQueryRequest;

typedef struct _google_firestore_v1_RunQueryResponse {
    google_firestore_v1_Document document;
    pb_bytes_array_t *transaction;
    google_protobuf_Timestamp read_time;
    int32_t skipped_results;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_RunQueryResponse) */
} google_firestore_v1_RunQueryResponse;

typedef struct _google_firestore_v1_TargetChange {
    google_firestore_v1_TargetChange_TargetChangeType target_change_type;
    pb_size_t target_ids_count;
    int32_t *target_ids;
    bool has_cause;
    google_rpc_Status cause;
    pb_bytes_array_t *resume_token;
    google_protobuf_Timestamp read_time;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_TargetChange) */
} google_firestore_v1_TargetChange;

typedef struct _google_firestore_v1_Target_QueryTarget {
    pb_bytes_array_t *parent;
    pb_size_t which_query_type;
    union {
        google_firestore_v1_StructuredQuery structured_query;
    };

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_Target_QueryTarget) */
} google_firestore_v1_Target_QueryTarget;

typedef struct _google_firestore_v1_UpdateDocumentRequest {
    google_firestore_v1_Document document;
    google_firestore_v1_DocumentMask update_mask;
    google_firestore_v1_DocumentMask mask;
    google_firestore_v1_Precondition current_document;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_UpdateDocumentRequest) */
} google_firestore_v1_UpdateDocumentRequest;

typedef struct _google_firestore_v1_WriteResponse {
    pb_bytes_array_t *stream_id;
    pb_bytes_array_t *stream_token;
    pb_size_t write_results_count;
    struct _google_firestore_v1_WriteResult *write_results;
    google_protobuf_Timestamp commit_time;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_WriteResponse) */
} google_firestore_v1_WriteResponse;

typedef struct _google_firestore_v1_ListenResponse {
    pb_size_t which_response_type;
    union {
        google_firestore_v1_TargetChange target_change;
        google_firestore_v1_DocumentChange document_change;
        google_firestore_v1_DocumentDelete document_delete;
        google_firestore_v1_ExistenceFilter filter;
        google_firestore_v1_DocumentRemove document_remove;
    };

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListenResponse) */
} google_firestore_v1_ListenResponse;

typedef struct _google_firestore_v1_Target {
    pb_size_t which_target_type;
    union {
        google_firestore_v1_Target_QueryTarget query;
        google_firestore_v1_Target_DocumentsTarget documents;
    } target_type;
    pb_size_t which_resume_type;
    union {
        pb_bytes_array_t *resume_token;
        google_protobuf_Timestamp read_time;
    } resume_type;
    int32_t target_id;
    bool once;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_Target) */
} google_firestore_v1_Target;

typedef struct _google_firestore_v1_ListenRequest {
    pb_bytes_array_t *database;
    pb_size_t which_target_change;
    union {
        google_firestore_v1_Target add_target;
        int32_t remove_target;
    };
    pb_size_t labels_count;
    struct _google_firestore_v1_ListenRequest_LabelsEntry *labels;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_ListenRequest) */
} google_firestore_v1_ListenRequest;

/* Default values for struct fields */

/* Initializer values for message structs */
#define google_firestore_v1_GetDocumentRequest_init_default {NULL, google_firestore_v1_DocumentMask_init_default, 0, {NULL}}
#define google_firestore_v1_ListDocumentsRequest_init_default {NULL, NULL, 0, NULL, NULL, google_firestore_v1_DocumentMask_init_default, 0, {NULL}, 0}
#define google_firestore_v1_ListDocumentsResponse_init_default {0, NULL, NULL}
#define google_firestore_v1_CreateDocumentRequest_init_default {NULL, NULL, NULL, google_firestore_v1_Document_init_default, google_firestore_v1_DocumentMask_init_default}
#define google_firestore_v1_UpdateDocumentRequest_init_default {google_firestore_v1_Document_init_default, google_firestore_v1_DocumentMask_init_default, google_firestore_v1_DocumentMask_init_default, google_firestore_v1_Precondition_init_default}
#define google_firestore_v1_DeleteDocumentRequest_init_default {NULL, google_firestore_v1_Precondition_init_default}
#define google_firestore_v1_BatchGetDocumentsRequest_init_default {NULL, 0, NULL, google_firestore_v1_DocumentMask_init_default, 0, {NULL}}
#define google_firestore_v1_BatchGetDocumentsResponse_init_default {0, {google_firestore_v1_Document_init_default}, NULL, google_protobuf_Timestamp_init_default}
#define google_firestore_v1_BeginTransactionRequest_init_default {NULL, google_firestore_v1_TransactionOptions_init_default}
#define google_firestore_v1_BeginTransactionResponse_init_default {NULL}
#define google_firestore_v1_CommitRequest_init_default {NULL, 0, NULL, NULL}
#define google_firestore_v1_CommitResponse_init_default {0, NULL, google_protobuf_Timestamp_init_default}
#define google_firestore_v1_RollbackRequest_init_default {NULL, NULL}
#define google_firestore_v1_RunQueryRequest_init_default {NULL, 0, {google_firestore_v1_StructuredQuery_init_default}, 0, {NULL}}
#define google_firestore_v1_RunQueryResponse_init_default {google_firestore_v1_Document_init_default, NULL, google_protobuf_Timestamp_init_default, 0}
#define google_firestore_v1_WriteRequest_init_default {NULL, NULL, 0, NULL, NULL, 0, NULL}
#define google_firestore_v1_WriteRequest_LabelsEntry_init_default {NULL, NULL}
#define google_firestore_v1_WriteResponse_init_default {NULL, NULL, 0, NULL, google_protobuf_Timestamp_init_default}
#define google_firestore_v1_ListenRequest_init_default {NULL, 0, {google_firestore_v1_Target_init_default}, 0, NULL}
#define google_firestore_v1_ListenRequest_LabelsEntry_init_default {NULL, NULL}
#define google_firestore_v1_ListenResponse_init_default {0, {google_firestore_v1_TargetChange_init_default}}
#define google_firestore_v1_Target_init_default  {0, {google_firestore_v1_Target_QueryTarget_init_default}, 0, {NULL}, 0, 0}
#define google_firestore_v1_Target_DocumentsTarget_init_default {0, NULL}
#define google_firestore_v1_Target_QueryTarget_init_default {NULL, 0, {google_firestore_v1_StructuredQuery_init_default}}
#define google_firestore_v1_TargetChange_init_default {_google_firestore_v1_TargetChange_TargetChangeType_MIN, 0, NULL, false, google_rpc_Status_init_default, NULL, google_protobuf_Timestamp_init_default}
#define google_firestore_v1_ListCollectionIdsRequest_init_default {NULL, 0, NULL}
#define google_firestore_v1_ListCollectionIdsResponse_init_default {0, NULL, NULL}
#define google_firestore_v1_GetDocumentRequest_init_zero {NULL, google_firestore_v1_DocumentMask_init_zero, 0, {NULL}}
#define google_firestore_v1_ListDocumentsRequest_init_zero {NULL, NULL, 0, NULL, NULL, google_firestore_v1_DocumentMask_init_zero, 0, {NULL}, 0}
#define google_firestore_v1_ListDocumentsResponse_init_zero {0, NULL, NULL}
#define google_firestore_v1_CreateDocumentRequest_init_zero {NULL, NULL, NULL, google_firestore_v1_Document_init_zero, google_firestore_v1_DocumentMask_init_zero}
#define google_firestore_v1_UpdateDocumentRequest_init_zero {google_firestore_v1_Document_init_zero, google_firestore_v1_DocumentMask_init_zero, google_firestore_v1_DocumentMask_init_zero, google_firestore_v1_Precondition_init_zero}
#define google_firestore_v1_DeleteDocumentRequest_init_zero {NULL, google_firestore_v1_Precondition_init_zero}
#define google_firestore_v1_BatchGetDocumentsRequest_init_zero {NULL, 0, NULL, google_firestore_v1_DocumentMask_init_zero, 0, {NULL}}
#define google_firestore_v1_BatchGetDocumentsResponse_init_zero {0, {google_firestore_v1_Document_init_zero}, NULL, google_protobuf_Timestamp_init_zero}
#define google_firestore_v1_BeginTransactionRequest_init_zero {NULL, google_firestore_v1_TransactionOptions_init_zero}
#define google_firestore_v1_BeginTransactionResponse_init_zero {NULL}
#define google_firestore_v1_CommitRequest_init_zero {NULL, 0, NULL, NULL}
#define google_firestore_v1_CommitResponse_init_zero {0, NULL, google_protobuf_Timestamp_init_zero}
#define google_firestore_v1_RollbackRequest_init_zero {NULL, NULL}
#define google_firestore_v1_RunQueryRequest_init_zero {NULL, 0, {google_firestore_v1_StructuredQuery_init_zero}, 0, {NULL}}
#define google_firestore_v1_RunQueryResponse_init_zero {google_firestore_v1_Document_init_zero, NULL, google_protobuf_Timestamp_init_zero, 0}
#define google_firestore_v1_WriteRequest_init_zero {NULL, NULL, 0, NULL, NULL, 0, NULL}
#define google_firestore_v1_WriteRequest_LabelsEntry_init_zero {NULL, NULL}
#define google_firestore_v1_WriteResponse_init_zero {NULL, NULL, 0, NULL, google_protobuf_Timestamp_init_zero}
#define google_firestore_v1_ListenRequest_init_zero {NULL, 0, {google_firestore_v1_Target_init_zero}, 0, NULL}
#define google_firestore_v1_ListenRequest_LabelsEntry_init_zero {NULL, NULL}
#define google_firestore_v1_ListenResponse_init_zero {0, {google_firestore_v1_TargetChange_init_zero}}
#define google_firestore_v1_Target_init_zero     {0, {google_firestore_v1_Target_QueryTarget_init_zero}, 0, {NULL}, 0, 0}
#define google_firestore_v1_Target_DocumentsTarget_init_zero {0, NULL}
#define google_firestore_v1_Target_QueryTarget_init_zero {NULL, 0, {google_firestore_v1_StructuredQuery_init_zero}}
#define google_firestore_v1_TargetChange_init_zero {_google_firestore_v1_TargetChange_TargetChangeType_MIN, 0, NULL, false, google_rpc_Status_init_zero, NULL, google_protobuf_Timestamp_init_zero}
#define google_firestore_v1_ListCollectionIdsRequest_init_zero {NULL, 0, NULL}
#define google_firestore_v1_ListCollectionIdsResponse_init_zero {0, NULL, NULL}

/* Field tags (for use in manual encoding/decoding) */
#define google_firestore_v1_BeginTransactionResponse_transaction_tag 1
#define google_firestore_v1_CommitRequest_database_tag 1
#define google_firestore_v1_CommitRequest_writes_tag 2
#define google_firestore_v1_CommitRequest_transaction_tag 3
#define google_firestore_v1_ListCollectionIdsResponse_collection_ids_tag 1
#define google_firestore_v1_ListCollectionIdsResponse_next_page_token_tag 2
#define google_firestore_v1_ListDocumentsResponse_documents_tag 1
#define google_firestore_v1_ListDocumentsResponse_next_page_token_tag 2
#define google_firestore_v1_ListenRequest_LabelsEntry_key_tag 1
#define google_firestore_v1_ListenRequest_LabelsEntry_value_tag 2
#define google_firestore_v1_RollbackRequest_database_tag 1
#define google_firestore_v1_RollbackRequest_transaction_tag 2
#define google_firestore_v1_Target_DocumentsTarget_documents_tag 2
#define google_firestore_v1_WriteRequest_database_tag 1
#define google_firestore_v1_WriteRequest_stream_id_tag 2
#define google_firestore_v1_WriteRequest_writes_tag 3
#define google_firestore_v1_WriteRequest_stream_token_tag 4
#define google_firestore_v1_WriteRequest_labels_tag 5
#define google_firestore_v1_WriteRequest_LabelsEntry_key_tag 1
#define google_firestore_v1_WriteRequest_LabelsEntry_value_tag 2
#define google_firestore_v1_BatchGetDocumentsRequest_transaction_tag 4
#define google_firestore_v1_BatchGetDocumentsRequest_new_transaction_tag 5
#define google_firestore_v1_BatchGetDocumentsRequest_read_time_tag 7
#define google_firestore_v1_BatchGetDocumentsRequest_database_tag 1
#define google_firestore_v1_BatchGetDocumentsRequest_documents_tag 2
#define google_firestore_v1_BatchGetDocumentsRequest_mask_tag 3
#define google_firestore_v1_BatchGetDocumentsResponse_found_tag 1
#define google_firestore_v1_BatchGetDocumentsResponse_missing_tag 2
#define google_firestore_v1_BatchGetDocumentsResponse_transaction_tag 3
#define google_firestore_v1_BatchGetDocumentsResponse_read_time_tag 4
#define google_firestore_v1_BeginTransactionRequest_database_tag 1
#define google_firestore_v1_BeginTransactionRequest_options_tag 2
#define google_firestore_v1_CommitResponse_write_results_tag 1
#define google_firestore_v1_CommitResponse_commit_time_tag 2
#define google_firestore_v1_CreateDocumentRequest_parent_tag 1
#define google_firestore_v1_CreateDocumentRequest_collection_id_tag 2
#define google_firestore_v1_CreateDocumentRequest_document_id_tag 3
#define google_firestore_v1_CreateDocumentRequest_document_tag 4
#define google_firestore_v1_CreateDocumentRequest_mask_tag 5
#define google_firestore_v1_DeleteDocumentRequest_name_tag 1
#define google_firestore_v1_DeleteDocumentRequest_current_document_tag 2
#define google_firestore_v1_GetDocumentRequest_transaction_tag 3
#define google_firestore_v1_GetDocumentRequest_read_time_tag 5
#define google_firestore_v1_GetDocumentRequest_name_tag 1
#define google_firestore_v1_GetDocumentRequest_mask_tag 2
#define google_firestore_v1_ListCollectionIdsRequest_parent_tag 1
#define google_firestore_v1_ListCollectionIdsRequest_page_size_tag 2
#define google_firestore_v1_ListCollectionIdsRequest_page_token_tag 3
#define google_firestore_v1_ListDocumentsRequest_transaction_tag 8
#define google_firestore_v1_ListDocumentsRequest_read_time_tag 10
#define google_firestore_v1_ListDocumentsRequest_parent_tag 1
#define google_firestore_v1_ListDocumentsRequest_collection_id_tag 2
#define google_firestore_v1_ListDocumentsRequest_page_size_tag 3
#define google_firestore_v1_ListDocumentsRequest_page_token_tag 4
#define google_firestore_v1_ListDocumentsRequest_order_by_tag 6
#define google_firestore_v1_ListDocumentsRequest_mask_tag 7
#define google_firestore_v1_ListDocumentsRequest_show_missing_tag 12
#define google_firestore_v1_RunQueryRequest_structured_query_tag 2
#define google_firestore_v1_RunQueryRequest_transaction_tag 5
#define google_firestore_v1_RunQueryRequest_new_transaction_tag 6
#define google_firestore_v1_RunQueryRequest_read_time_tag 7
#define google_firestore_v1_RunQueryRequest_parent_tag 1
#define google_firestore_v1_RunQueryResponse_transaction_tag 2
#define google_firestore_v1_RunQueryResponse_document_tag 1
#define google_firestore_v1_RunQueryResponse_read_time_tag 3
#define google_firestore_v1_RunQueryResponse_skipped_results_tag 4
#define google_firestore_v1_TargetChange_target_change_type_tag 1
#define google_firestore_v1_TargetChange_target_ids_tag 2
#define google_firestore_v1_TargetChange_cause_tag 3
#define google_firestore_v1_TargetChange_resume_token_tag 4
#define google_firestore_v1_TargetChange_read_time_tag 6
#define google_firestore_v1_Target_QueryTarget_structured_query_tag 2
#define google_firestore_v1_Target_QueryTarget_parent_tag 1
#define google_firestore_v1_UpdateDocumentRequest_document_tag 1
#define google_firestore_v1_UpdateDocumentRequest_update_mask_tag 2
#define google_firestore_v1_UpdateDocumentRequest_mask_tag 3
#define google_firestore_v1_UpdateDocumentRequest_current_document_tag 4
#define google_firestore_v1_WriteResponse_stream_id_tag 1
#define google_firestore_v1_WriteResponse_stream_token_tag 2
#define google_firestore_v1_WriteResponse_write_results_tag 3
#define google_firestore_v1_WriteResponse_commit_time_tag 4
#define google_firestore_v1_ListenResponse_target_change_tag 2
#define google_firestore_v1_ListenResponse_document_change_tag 3
#define google_firestore_v1_ListenResponse_document_delete_tag 4
#define google_firestore_v1_ListenResponse_filter_tag 5
#define google_firestore_v1_ListenResponse_document_remove_tag 6
#define google_firestore_v1_Target_query_tag     2
#define google_firestore_v1_Target_documents_tag 3
#define google_firestore_v1_Target_resume_token_tag 4
#define google_firestore_v1_Target_read_time_tag 11
#define google_firestore_v1_Target_target_id_tag 5
#define google_firestore_v1_Target_once_tag      6
#define google_firestore_v1_ListenRequest_add_target_tag 2
#define google_firestore_v1_ListenRequest_remove_target_tag 3
#define google_firestore_v1_ListenRequest_database_tag 1
#define google_firestore_v1_ListenRequest_labels_tag 4

/* Struct field encoding specification for nanopb */
extern const pb_field_t google_firestore_v1_GetDocumentRequest_fields[5];
extern const pb_field_t google_firestore_v1_ListDocumentsRequest_fields[10];
extern const pb_field_t google_firestore_v1_ListDocumentsResponse_fields[3];
extern const pb_field_t google_firestore_v1_CreateDocumentRequest_fields[6];
extern const pb_field_t google_firestore_v1_UpdateDocumentRequest_fields[5];
extern const pb_field_t google_firestore_v1_DeleteDocumentRequest_fields[3];
extern const pb_field_t google_firestore_v1_BatchGetDocumentsRequest_fields[7];
extern const pb_field_t google_firestore_v1_BatchGetDocumentsResponse_fields[5];
extern const pb_field_t google_firestore_v1_BeginTransactionRequest_fields[3];
extern const pb_field_t google_firestore_v1_BeginTransactionResponse_fields[2];
extern const pb_field_t google_firestore_v1_CommitRequest_fields[4];
extern const pb_field_t google_firestore_v1_CommitResponse_fields[3];
extern const pb_field_t google_firestore_v1_RollbackRequest_fields[3];
extern const pb_field_t google_firestore_v1_RunQueryRequest_fields[6];
extern const pb_field_t google_firestore_v1_RunQueryResponse_fields[5];
extern const pb_field_t google_firestore_v1_WriteRequest_fields[6];
extern const pb_field_t google_firestore_v1_WriteRequest_LabelsEntry_fields[3];
extern const pb_field_t google_firestore_v1_WriteResponse_fields[5];
extern const pb_field_t google_firestore_v1_ListenRequest_fields[5];
extern const pb_field_t google_firestore_v1_ListenRequest_LabelsEntry_fields[3];
extern const pb_field_t google_firestore_v1_ListenResponse_fields[6];
extern const pb_field_t google_firestore_v1_Target_fields[7];
extern const pb_field_t google_firestore_v1_Target_DocumentsTarget_fields[2];
extern const pb_field_t google_firestore_v1_Target_QueryTarget_fields[3];
extern const pb_field_t google_firestore_v1_TargetChange_fields[6];
extern const pb_field_t google_firestore_v1_ListCollectionIdsRequest_fields[4];
extern const pb_field_t google_firestore_v1_ListCollectionIdsResponse_fields[3];

/* Maximum encoded size of messages (where known) */
/* google_firestore_v1_GetDocumentRequest_size depends on runtime parameters */
/* google_firestore_v1_ListDocumentsRequest_size depends on runtime parameters */
/* google_firestore_v1_ListDocumentsResponse_size depends on runtime parameters */
/* google_firestore_v1_CreateDocumentRequest_size depends on runtime parameters */
#define google_firestore_v1_UpdateDocumentRequest_size (44 + google_firestore_v1_Document_size + google_firestore_v1_DocumentMask_size + google_firestore_v1_DocumentMask_size)
/* google_firestore_v1_DeleteDocumentRequest_size depends on runtime parameters */
/* google_firestore_v1_BatchGetDocumentsRequest_size depends on runtime parameters */
/* google_firestore_v1_BatchGetDocumentsResponse_size depends on runtime parameters */
/* google_firestore_v1_BeginTransactionRequest_size depends on runtime parameters */
/* google_firestore_v1_BeginTransactionResponse_size depends on runtime parameters */
/* google_firestore_v1_CommitRequest_size depends on runtime parameters */
/* google_firestore_v1_CommitResponse_size depends on runtime parameters */
/* google_firestore_v1_RollbackRequest_size depends on runtime parameters */
/* google_firestore_v1_RunQueryRequest_size depends on runtime parameters */
/* google_firestore_v1_RunQueryResponse_size depends on runtime parameters */
/* google_firestore_v1_WriteRequest_size depends on runtime parameters */
/* google_firestore_v1_WriteRequest_LabelsEntry_size depends on runtime parameters */
/* google_firestore_v1_WriteResponse_size depends on runtime parameters */
/* google_firestore_v1_ListenRequest_size depends on runtime parameters */
/* google_firestore_v1_ListenRequest_LabelsEntry_size depends on runtime parameters */
/* google_firestore_v1_ListenResponse_size depends on runtime parameters */
/* google_firestore_v1_Target_size depends on runtime parameters */
/* google_firestore_v1_Target_DocumentsTarget_size depends on runtime parameters */
/* google_firestore_v1_Target_QueryTarget_size depends on runtime parameters */
/* google_firestore_v1_TargetChange_size depends on runtime parameters */
/* google_firestore_v1_ListCollectionIdsRequest_size depends on runtime parameters */
/* google_firestore_v1_ListCollectionIdsResponse_size depends on runtime parameters */

/* Message IDs (where set with "msgid" option) */
#ifdef PB_MSGID

#define FIRESTORE_MESSAGES \


#endif

const char* EnumToString(
    google_firestore_v1_TargetChange_TargetChangeType value);
}  // namespace firestore
}  // namespace firebase

/* @@protoc_insertion_point(eof) */

#endif
