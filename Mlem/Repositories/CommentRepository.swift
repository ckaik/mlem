// 
//  CommentRepository.swift
//  Mlem
//
//  Created by mormaer on 14/07/2023.
//  
//

import Foundation
import Dependencies

class CommentRepository {
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.errorHandler) var errorHandler
    
    func comments(for postId: Int) async -> [HierarchicalComment] {
        do {
            return try await apiClient
                .loadComments(for: postId)
                .hierarchicalRepresentation
        } catch {
            errorHandler.handle(
                .init(
                    title: "Failed to load comments",
                    message: "Please refresh to try again",
                    underlyingError: error
                )
            )
            
            return []
        }
    }
    
    @discardableResult
    func postComment(
        content: String,
        languageId: Int? = nil,
        parentId: Int? = nil,
        postId: Int
    ) async -> HierarchicalComment? {
        do {
            let response = try await apiClient
                .createComment(
                    content: content,
                    languageId: languageId,
                    parentId: parentId,
                    postId: postId
                )
            
            return .init(comment: response.commentView, children: [])
        } catch {
            errorHandler.handle(
                .init(
                    title: "Failed to post comment",
                    message: "Please try again",
                    underlyingError: error
                )
            )
        }
        
        return nil
    }
}
